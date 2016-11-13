package com.food.ecokitchen.actvities;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.food.ecokitchen.R;
import com.food.ecokitchen.adapters.Mapadapters;
import com.food.ecokitchen.utils.MyConstants;
import com.food.ecokitchen.utils.ServiceHandler;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import static android.R.attr.value;

public class Findnearbykiosks extends AppCompatActivity {

    List<Mapadapters> markersArray = new ArrayList<Mapadapters>();
    private GoogleMap googleMap;
    String jsonStr;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_available_donations);
        //initView();

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        final ActionBar ab = getSupportActionBar();
        //ab.setHomeAsUpIndicator(R.mipmap.ic_launcher);
        ab.setDisplayHomeAsUpEnabled(true);

        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        // Google Map

        loadLocations();


        try {
            // Loading map
            initilizeMap();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    private void initilizeMap() {
        if (googleMap == null) {
            googleMap = ((MapFragment) getFragmentManager().findFragmentById(R.id.map)).getMap();

            // check if map is created successfully or not
            if (googleMap == null) {
                Toast.makeText(getApplicationContext(),
                        "Sorry! unable to create maps", Toast.LENGTH_SHORT)
                        .show();
            }
        }
    }

    private void loadLocations() {
        new loadLocationsAsyncTask().execute();
    }

    private void displayToast(String toastMsg) {
        Toast.makeText(getApplicationContext(),toastMsg,Toast.LENGTH_SHORT).show();
    }

    /**
     * Async task class to get json by making HTTP call
     * */
    private class loadLocationsAsyncTask extends AsyncTask<Void, Void, Void> {

        ProgressDialog pDialog;
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Showing progress dialog
            pDialog = new ProgressDialog(Findnearbykiosks.this);
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
            String sUrl = MyConstants.URL_ROOT+"locations";

             jsonStr = serviceHandler.performGetCall(sUrl);

            Log.e("Response: ", "--->>> " + jsonStr);

            if (jsonStr != null) try {
                JSONArray jsonArray = new JSONArray(jsonStr);
                if (jsonArray != null && jsonArray.length() > 0) {

                    for(int i=0;i<jsonArray.length();i++)
                    {JSONObject jsonObject1 = jsonArray.getJSONObject(i);

                        Mapadapters mapadapters = new Mapadapters();

                        mapadapters.setAddress(jsonObject1.getString("address"));
                        mapadapters.setDescription(jsonObject1.getString("description"));
                        mapadapters.setLat(jsonObject1.getDouble("lat"));
                        mapadapters.setLong1(jsonObject1.getDouble("long"));
                        mapadapters.setStatus(jsonObject1.getString("status"));

                        markersArray.add(mapadapters);

                    }
                    System.out.println(markersArray.size()+"here");
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

            for (int i = 0; i < markersArray.size(); i++) {

//                drawMarker(new LatLng(Double.parseDouble(locationList.get(i).getLatitude()), Double.parseDouble(locationList.get(i).getLongitude())), locationList.get(i).getNo());
                LatLng latLng = new LatLng(markersArray.get(i).getLat(), (markersArray.get(i).getLong1()));
                if (!markersArray.get(i).getStatus().equalsIgnoreCase("false")) {
                    System.out.println(markersArray.size() + "imhere");
                    googleMap.addMarker(new MarkerOptions()
                            .position(latLng) //setting position
                            .draggable(true) //Making the marker draggable
                            //.snippet(locationInfoList.get(i).getAddress() + "\nDistance : " + new DecimalFormat("#.00").format(distance) + " km")
                            .snippet(markersArray.get(i).getAddress() + "\nDescription " + markersArray.get(i).getDescription())
//                            .title(markersArray.get(i).getStatus()) //Adding a title
                            .title(markersArray.get(i).getStatus()) //Adding a title
                            .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN)));
                    googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(markersArray.get(i).getLat(), (markersArray.get(i).getLong1())), 10));

                }
            }

        }

    }





}
