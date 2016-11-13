package com.food.ecokitchen.actvities;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RatingBar;
import android.widget.Spinner;
import android.widget.Toast;

import com.food.ecokitchen.R;
import com.food.ecokitchen.utils.AppSharedPreferences;
import com.food.ecokitchen.utils.MyConstants;
import com.food.ecokitchen.utils.ServiceHandler;

import org.json.JSONException;
import org.json.JSONObject;

public class Feedback extends AppCompatActivity {
    String requestParams,feed,Success="not";
    AppSharedPreferences appSharedPreferences;
    Float courtesy,Quant,Qual,tas,clean;
    RatingBar coe,Quantity,Quality,taste,Cleanliness;
    EditText feedback;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feedback);

        appSharedPreferences = new AppSharedPreferences(getApplicationContext());
         coe = (RatingBar)findViewById(R.id.ratingBar);
         Quantity = (RatingBar)findViewById(R.id.ratingBar2);
         Quality = (RatingBar)findViewById(R.id.ratingBar3);
         taste = (RatingBar)findViewById(R.id.ratingBar4);
         Cleanliness = (RatingBar)findViewById(R.id.ratingBar5);
         feedback = (EditText)findViewById(R.id.etfeedback);



        findViewById(R.id.btn_sendFeedback).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                courtesy = coe.getRating();
                Quant = Quantity.getRating();
                Qual = Quality.getRating();
                tas = taste.getRating();
                clean = Cleanliness.getRating();
                feed = feedback.getText().toString().trim();
                JSONObject object = new JSONObject();
                try {
                    object.put("content",feed);
                    object.put("locationId","1");
                    object.put("userId",appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_ID));
                    object.put("courtesy",courtesy );
                    object.put("cleanliness",clean);
                    object.put("qualityOfFood",Qual);
                    object.put("quantityOfFood",Quant);
                    object.put("foodTaste",tas);

                    requestParams = object.toString();
                    Log.e("login","--->>> "+requestParams);
                    new feedbackAsyncTask().execute();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });


    }

    private class feedbackAsyncTask extends AsyncTask<Void, Void, Void> {

        ProgressDialog pDialog;
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Showing progress dialog
            pDialog = new ProgressDialog(Feedback.this);
            pDialog.setMessage("Please wait...");
            pDialog.setCancelable(false);
            pDialog.show();

        }

        @Override
        protected Void doInBackground(Void... arg0) {
            // Creating service handler class instance
            ServiceHandler serviceHandler = new ServiceHandler();


            // Making a request to url and getting response
            //String jsonStr = sh.makeServiceCall(url, ServiceHandler.GET);
            String sUrl = MyConstants.URL_ROOT + "feedback";

            String jsonStr = serviceHandler.performPostCall(sUrl, requestParams);

            Log.e("Response: ", "--->>> " + jsonStr);
            if (jsonStr != null) try {
                JSONObject jsonObj = new JSONObject(jsonStr);
                if (jsonObj != null) {
                    Success= jsonObj.getString("success");
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
            else {
                Log.e("ServiceHandler", "Couldn't get any data from the url");
            }

            return null;
        }

            @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);
            // Dismiss the progress dialog
            if (pDialog.isShowing())
                pDialog.dismiss();
                if (!Success.equals("not")) {
                    finish();
                    Intent intent = new Intent(getApplicationContext(), ThankYouActivity.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
            }else{
                displayToast(getString(R.string.apidown));
            }
        }

    }
    private void displayToast(String toastMsg) {
        Toast.makeText(getApplicationContext(), toastMsg, Toast.LENGTH_SHORT).show();
    }

}
