package com.food.ecokitchen.actvities;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.food.ecokitchen.R;
import com.food.ecokitchen.utils.AppSharedPreferences;
import com.food.ecokitchen.utils.MyConstants;
import com.food.ecokitchen.utils.ServiceHandler;

import org.json.JSONException;
import org.json.JSONObject;

public class RegistrationActivity extends AppCompatActivity {
    String name, mobile, passd, repassd, address, email;
    Button reg;
    EditText etname, etph, etemail, etpass, etrepass, etaddress;
    AppSharedPreferences appSharedPreferences;
    String requestParams,message;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registration);
        reg = (Button) findViewById(R.id.btn_register);
        etname = (EditText) findViewById(R.id.edt_name);
        etph = (EditText) findViewById(R.id.edt_phone);
        etemail = (EditText) findViewById(R.id.edt_mail);
        etpass = (EditText) findViewById(R.id.edt_passd);
        etrepass = (EditText) findViewById(R.id.edt_cpassd);
        etaddress = (EditText) findViewById(R.id.edt_add);

        String deviceId = Settings.Secure.getString(getApplicationContext().getContentResolver(), Settings.Secure.ANDROID_ID);
        appSharedPreferences = new AppSharedPreferences(getApplicationContext());
        appSharedPreferences.saveStringPreferences(MyConstants.PREF_KEY_DEVICE_ID,deviceId);

        reg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                name = String.valueOf(etname.getText());
                mobile = String.valueOf(etph.getText());
                email = String.valueOf(etemail.getText());
                address = String.valueOf(etaddress.getText());
                passd = String.valueOf(etpass.getText());
                repassd = String.valueOf(etrepass.getText());
                if (name.length() <= 1 || mobile.length() <= 9 || passd.length() <= 1) {

                    displayToast(getString(R.string.required));
                }
                System.out.println(passd+"hhhh"+repassd);
                Log.d("Msg",passd+","+repassd);

                if (passd.equals(repassd)) {
                    doLoginTask();
                } else {
                    displayToast(getString(R.string.passwd_not_match));
                }
            }
        });

    }

    private void doLoginTask() {
        JSONObject object = new JSONObject();
        try {
            object.put("mobile","8883729796");
            object.put("password","Paypal");
            object.put("address","Malibu Point");
            object.put("email","neo3@gmail.com");
            object.put("name","Paypal");
            requestParams = object.toString();
            Log.e("login","--->>> "+requestParams);
            new RegistrationActivity.doLoginAsyncTask().execute();

//            Intent intent = new Intent(getApplicationContext(), DashBoardActivity.class);
//            startActivity(intent);

        } catch (Exception ex) {
            displayToast(getString(R.string.unable_to_connect));
        }
    }

    private void displayToast(String toastMsg) {
        Toast.makeText(getApplicationContext(), toastMsg, Toast.LENGTH_SHORT).show();
    }

    private class doLoginAsyncTask extends AsyncTask<Void, Void, Void> {

        ProgressDialog pDialog;

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Showing progress dialog
            pDialog = new ProgressDialog(RegistrationActivity.this);
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
            String sUrl = MyConstants.URL_ROOT + "signup";

            String jsonStr = serviceHandler.performPostCall(sUrl, requestParams);

            Log.e("Response: ", "--->>> " + jsonStr);

            if (jsonStr != null) try {
                JSONObject jsonObj = new JSONObject(jsonStr);
                if (jsonObj != null) {
                    if (!jsonObj.isNull("userId")) {
                        if (!jsonObj.getString("userId").equals("")) {
                            appSharedPreferences.saveStringPreferences(MyConstants.PREF_KEY_ID, jsonObj.getString("userId"));
                            appSharedPreferences.saveBooleanPreferences(MyConstants.PREF_KEY_IS_LOGGEDIN, true);
                        }

                    }
                    if (!jsonObj.getString("success").equalsIgnoreCase("false")) {
                        message= jsonObj.getString("message");
                        System.out.print(message);
                    }
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
            if (!appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_ID).equals("")) {
                savePreferences();
                finish();
                Intent intent = new Intent(getApplicationContext(), DashBoardActivity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
            } else {
                displayToast(message);
            }
        }



    }

    private void savePreferences() {
        appSharedPreferences.saveStringPreferences(MyConstants.PREF_KEY_NAME, name);
        appSharedPreferences.saveStringPreferences(MyConstants.PREF_KEY_MOBILE, mobile);
        appSharedPreferences.saveBooleanPreferences(MyConstants.PREF_KEY_IS_LOGGEDIN, true);
    }
}