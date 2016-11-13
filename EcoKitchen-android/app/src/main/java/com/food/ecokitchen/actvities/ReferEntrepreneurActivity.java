package com.food.ecokitchen.actvities;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import com.food.ecokitchen.R;
import com.food.ecokitchen.utils.AppSharedPreferences;
import com.food.ecokitchen.utils.MyConstants;
import com.food.ecokitchen.utils.ServiceHandler;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.Places;
import com.google.android.gms.location.places.ui.PlacePicker;
import com.google.android.gms.maps.model.LatLng;

import org.json.JSONException;
import org.json.JSONObject;

public class ReferEntrepreneurActivity extends AppCompatActivity implements GoogleApiClient.OnConnectionFailedListener,
        GoogleApiClient.ConnectionCallbacks{

    private GoogleApiClient mGoogleApiClient;
    private int PLACE_PICKER_REQUEST = 1;
    private RadioButton married,unmarried,others,less5000,less10000,less20000,more20000,primary,middle,sslc,none;
    String entname ="";
    String entphone ="";
    String entdescription ="";
    String entadress = "";
    private String Marritalstatus = "others",incomerange = "",educationalstatus = "";
            //,lat = "",lng = "",userid= "";
    EditText editname;
    EditText editphone;
    EditText editdescription;
    EditText editaddress;
    private String requestParams;
    AppSharedPreferences appSharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_donations_details_entry);
        //initView();

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        appSharedPreferences = new AppSharedPreferences(getApplicationContext());
        //userid = appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_ID);

       married = (RadioButton)findViewById(R.id.radio_married);
        unmarried = (RadioButton)findViewById(R.id.radio_unmarried);
        others = (RadioButton)findViewById(R.id.radio_others);

        less5000 = (RadioButton)findViewById(R.id.radio_less5000);
        less10000 = (RadioButton)findViewById(R.id.radio_less10000);
        less20000 = (RadioButton)findViewById(R.id.radio_less20000);

        more20000= (RadioButton)findViewById(R.id.radio_more20000);
        primary = (RadioButton)findViewById(R.id.radio_primary);
        middle = (RadioButton)findViewById(R.id.radio_Middle);
        sslc = (RadioButton)findViewById(R.id.radio_sslc);
        none = (RadioButton)findViewById(R.id.radio_None);

        editname = (EditText)findViewById(R.id.edt_name);
        editphone = (EditText)findViewById(R.id.edt_phone);
        editdescription = (EditText)findViewById(R.id.edt_extradetails);
        editaddress = (EditText)findViewById(R.id.edt_entadd);


//       EditText edtname = (EditText)findViewById(R.id.edt_name);
//        EditText edtphone = (EditText)findViewById(R.id.edt_phone);
//        EditText edtdescription = (EditText)findViewById(R.id.edt_extradetails);

        mGoogleApiClient = new GoogleApiClient
                .Builder( this )
                .enableAutoManage( this, 0, this )
                .addApi( Places.GEO_DATA_API )
                .addApi( Places.PLACE_DETECTION_API )
                .addConnectionCallbacks( this )
                .addOnConnectionFailedListener( this )
                .build();

        final ActionBar ab = getSupportActionBar();
        //ab.setHomeAsUpIndicator(R.mipma);
        ab.setDisplayHomeAsUpEnabled(true);

        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        findViewById(R.id.txt_select_location).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                displayPlacePicker();
            }
        });

        married.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    Marritalstatus = "Married";
                }
            }
        });
        unmarried.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                    Marritalstatus = "UnMarried";
                }
            }
        });
        others.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    Marritalstatus = "Others";
                }
            }
        });


        less5000.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    incomerange = "Less than 5000";
                }
            }
        });
        less10000.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                    incomerange = "Less than 10000";
                }
            }
        });
        less20000.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    incomerange = "Less than 10000";
                }
            }
        });

        more20000.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    incomerange = "More than 20000";
                }
            }
        });
        primary.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                   educationalstatus = "Primary";
                }
            }
        });
        middle.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    educationalstatus = "middle";
                }
            }
        });

        sslc.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    educationalstatus = "sslc";
                }
            }
        });
        none.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                    educationalstatus = "None";
                }
            }
        });

        String entname = editname.getText().toString().trim();
        String entphone = editphone.getText().toString().trim();
        String entdescription = editdescription.getText().toString().trim();
        String entadress = editaddress.getText().toString().trim();
        findViewById(R.id.btn_refent).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                submitDonation();
            }
        });

    }

    private void submitDonation() {

        String entname = editname.getText().toString().trim();
        String entphone = editphone.getText().toString().trim();
        String entdescription = editdescription.getText().toString().trim();


        if (isValidationSuccess()){
            doSubmitDonationTask();
        }
    }

    private void doSubmitDonationTask() {
        /*postParams = new HashMap<>();
        postParams.put("userid",userid);
        postParams.put("foodtype",foodType);
        postParams.put("quantity",quantity);
        postParams.put("latitude",lat);
        postParams.put("longitude",lng);
        postParams.put("address", address);*/
        /*{ "donorMobile": "9944775657", "donationStatus": "open",
                "foodType":"lunch", "quantity":"10",
                "latitude":"102.30", "longitude":"233.dd", "address":"Some text" }*/
        JSONObject object = new JSONObject();
        try {
            //object.put("consumerName", appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_NAME));
            //object.put("isVolunteer", String.valueOf(appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_IS_VOLUNTEER)));
            //object.put("deviceId", String.valueOf(appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_DEVICE_ID)));
            object.put("name", entname);
            //object.put("donorMobile", appSharedPreferences.getStringPreferences(MyConstants.PREF_KEY_MOBILE));
            object.put("maritalStatus", Marritalstatus);
            object.put("phone", entphone);
            object.put("incomeRange", incomerange);
            object.put("qualification", educationalstatus);
            object.put("description", entdescription);
            object.put("location", entadress);
            //object.put("deviceToken", "TestDeviceToken");
            requestParams = object.toString();
            Log.e("Params","--->>> "+requestParams);
            new doSubmitDonationAsyncTask().execute();
        } catch (Exception ex) {
            displayToast(getString(R.string.unable_to_connect));
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        if( mGoogleApiClient != null )
            mGoogleApiClient.connect();
    }

    @Override
    protected void onStop() {
        if( mGoogleApiClient != null && mGoogleApiClient.isConnected() ) {
            //mAdapter.setGoogleApiClient( null );
            mGoogleApiClient.disconnect();
        }
        super.onStop();
    }

    private void displayPlacePicker() {
        if( mGoogleApiClient == null || !mGoogleApiClient.isConnected() )
            return;

        PlacePicker.IntentBuilder builder = new PlacePicker.IntentBuilder();

        try {
            startActivityForResult( builder.build( getApplicationContext() ), PLACE_PICKER_REQUEST );
        } catch ( GooglePlayServicesRepairableException e ) {
            Log.d("PlacesAPI Demo", "GooglePlayServicesRepairableException thrown");
        } catch ( GooglePlayServicesNotAvailableException e ) {
            Log.d( "PlacesAPI Demo", "GooglePlayServicesNotAvailableException thrown" );
        }
    }

    protected void onActivityResult( int requestCode, int resultCode, Intent data ) {
        if( requestCode == PLACE_PICKER_REQUEST && resultCode == RESULT_OK ) {
            displayPlace( PlacePicker.getPlace( data, this ) );
        }
    }

    private void displayPlace( Place place ) {
        if( place == null )
            return;

        //DisplayLog.displayNormalLog("MainActivity","Place",place);

        String content = "";
        //if( !TextUtils.isEmpty(place.getName()) ) {
        //    content += "Name: " + place.getName() + "\n";
        //}
        if( !TextUtils.isEmpty(place.getAddress()) ) {
            content += place.getAddress();
        }
        //if( !TextUtils.isEmpty( place.getPhoneNumber() ) ) {
        //    content += "Phone: " + place.getPhoneNumber();
        //}

        if( !TextUtils.isEmpty( String.valueOf(place.getLatLng()) ) ) {
            Log.e("MainActivity", "Latlong: "+String.valueOf(place.getLatLng()));
            LatLng mLatLng = place.getLatLng();
            //isplayLog.displayNormalLog("MainActivity", "Latlong Points", mLatLng.latitude+" - "+mLatLng.longitude);
//            lat = String.valueOf(mLatLng.latitude);
//            lng = String.valueOf(mLatLng.longitude);

        }
        Log.e("Main ac","address: "+content);

//        if (content != null && !content.equals("")){
//            edtAddress.setText(content);
//        }else {
//            edtAddress.setText("");
//        }
        //mTextView.setText( content );
       // medtAddress.setText(content);
    }

    private boolean isValidationSuccess(){
        boolean isSuccess = true;
//        if (quantity.equals("")){
//            displayToast("Please enter the quantity");
//            isSuccess = false;
//        }else if (address.equals("") || address.length() < 5){
//            displayToast("Please enter the correct address");
//            isSuccess = false;
//        }else if (lat.equals("") || lng.equals("")){
//            displayToast("Please select the location");
//            isSuccess = false;
//        }
        return isSuccess;
    }

    private void displayToast(String toastMsg) {
        Toast.makeText(getApplicationContext(), toastMsg, Toast.LENGTH_SHORT).show();
    }

    /**
     * Async task class to get json by making HTTP call
     * */
    private class doSubmitDonationAsyncTask extends AsyncTask<Void, Void, Void> {

        ProgressDialog pDialog;
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Showing progress dialog
            pDialog = new ProgressDialog(ReferEntrepreneurActivity.this);
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
            String sUrl = MyConstants.URL_ROOT+"donate/create";

            String jsonStr = serviceHandler.performPostCall(sUrl, requestParams);

            Log.e("Response: ", "--->>> " + jsonStr);

            if (jsonStr != null) try {
                JSONObject jsonObj = new JSONObject(jsonStr);
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
            Intent intent =new Intent(getApplicationContext(),ThankYouActivity.class);
            startActivity(intent);
            intent.putExtra(MyConstants.FROM_ACTIVITY,MyConstants.KEY_DONOR);
            overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
            finish();
        }

    }


    @Override
    public void onConnected(Bundle bundle) {

    }

    @Override
    public void onConnectionSuspended(int i) {

    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {

    }
}
