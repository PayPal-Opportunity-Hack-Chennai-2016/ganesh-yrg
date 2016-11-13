package com.food.ecokitchen.actvities;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;
import android.widget.RelativeLayout;

import com.food.ecokitchen.R;
import com.food.ecokitchen.utils.AppSharedPreferences;
import com.food.ecokitchen.utils.MyConstants;

public class DashBoardActivity extends AppCompatActivity {

    private EditText edtName,edtPhone;
    private RelativeLayout layoutVolunteer,layout_About_Us,layout_FeedBack;
    private boolean isVolunteer;
    AppSharedPreferences appSharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dash_board);
        //initView();
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        layoutVolunteer = (RelativeLayout)findViewById(R.id.layout_volunteer);
        appSharedPreferences = new AppSharedPreferences(getApplicationContext());
        isVolunteer = appSharedPreferences.getBooleanPreferences(MyConstants.PREF_KEY_IS_VOLUNTEER);
//        if (isVolunteer)
//        {
//            layoutVolunteer.setVisibility(View.VISIBLE);
//        }else {
//            layoutVolunteer.setVisibility(View.GONE);
//        }
        layout_About_Us =(RelativeLayout)findViewById(R.id.layout_About_Us);
        layout_FeedBack =(RelativeLayout)findViewById(R.id.layout_FeedBack);
        final ActionBar ab = getSupportActionBar();
//        ab.setHomeAsUpIndicator(R.mipmap.ic_launcher);
//        ab.setDisplayHomeAsUpEnabled(true);

        findViewById(R.id.layout_donate_food).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                donationBtnClick();
            }
        });
        layoutVolunteer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                volunteerBtnClick();
            }
        });
        findViewById(R.id.layout_map_a_location).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mapLocationBtnClick();
            }
        });
        layout_FeedBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(),Feedback.class);
                startActivity(intent);
            }
        });
        layout_About_Us.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(),Aboutus.class);
                startActivity(intent);
            }
        });

    }

    private void donationBtnClick(){
        Intent intent = new Intent(getApplicationContext(),ReferEntrepreneurActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
    }

    private void volunteerBtnClick(){
        Intent intent = new Intent(getApplicationContext(),Findnearbykiosks.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
    }

    private void mapLocationBtnClick(){
        Intent intent = new Intent(getApplicationContext(),MapALocationActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in, R.anim.slide_out);
    }

    /*private void doLogin() {
        String name = edtName.getText().toString().trim();
        String mobile = edtPhone.getText().toString().trim();
        if (isValidationSuccess(name,mobile)){
            doLoginTask(name,mobile);
        }else {
            //displayToast();
        }
    }

    private void doLoginTask(String name, String mobile) {
        Intent intent = new Intent(getApplicationContext(),)
    }

    private void displayToast(String toastMsg) {
        Toast.makeText(getApplicationContext(),toastMsg,Toast.LENGTH_SHORT).show();
    }

    private boolean isValidationSuccess(String name, String mobile) {
        boolean isSuccess = true;

        if (name.length() > 3){
            isSuccess = false;
        }else if(!mobile.matches(MyConstants.REG_EXP_MOBILE)){
            isSuccess = false;
        }
        return isSuccess;
    }

    private void initView() {
        edtName = (EditText)findViewById(R.id.edt_name);
        edtPhone = (EditText)findViewById(R.id.edt_phone);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
*/
}
