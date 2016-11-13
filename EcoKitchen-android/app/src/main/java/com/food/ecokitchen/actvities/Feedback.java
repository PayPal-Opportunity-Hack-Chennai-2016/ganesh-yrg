package com.food.ecokitchen.actvities;

import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RatingBar;
import android.widget.Spinner;

import com.food.ecokitchen.R;

public class Feedback extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feedback);

        RatingBar coe = (RatingBar)findViewById(R.id.ratingBar);
        RatingBar Quantity = (RatingBar)findViewById(R.id.ratingBar2);
        RatingBar Quality = (RatingBar)findViewById(R.id.ratingBar3);
        RatingBar taste = (RatingBar)findViewById(R.id.ratingBar4);
        RatingBar Cleanliness = (RatingBar)findViewById(R.id.ratingBar5);
        EditText feedback = (EditText)findViewById(R.id.etfeedback);

        Float courtesy = coe.getRating();
        Float Quant = coe.getRating();
        Float Qual = coe.getRating();
        Float tas = coe.getRating();
        Float clean = coe.getRating();
        //String feed = feedback.getText();

//        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
//        setSupportActionBar(toolbar);
//        final ActionBar ab = getSupportActionBar();
//        //ab.setHomeAsUpIndicator(R.mipma);
//        ab.setDisplayHomeAsUpEnabled(true);
//        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                finish();
//            }
//        });

//        Spinner coe = (Spinner) findViewById(R.id.spinner6);
//        Spinner Quality = (Spinner) findViewById(R.id.spinner5);
//        Spinner Quantity = (Spinner) findViewById(R.id.spinner3);
//        Spinner taste = (Spinner) findViewById(R.id.spinner2);
//        Spinner Cleanliness = (Spinner) findViewById(R.id.spinner);
//
//        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, R.array.curt, android.R.layout.simple_spinner_item);
//        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        coe.setAdapter(adapter);
//
//        ArrayAdapter<CharSequence> Quality1 = ArrayAdapter.createFromResource(this, R.array.quality, android.R.layout.simple_spinner_item);
//        Quality1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        Quality.setAdapter(Quality1);
//
//        ArrayAdapter<CharSequence> Quantity1 = ArrayAdapter.createFromResource(this, R.array.quantity, android.R.layout.simple_spinner_item);
//        Quantity1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        Quantity.setAdapter(adapter);
//
//        ArrayAdapter<CharSequence> taste1 = ArrayAdapter.createFromResource(this, R.array.taste, android.R.layout.simple_spinner_item);
//        taste1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        taste.setAdapter(adapter);
//
//        ArrayAdapter<CharSequence> Cleanliness1 = ArrayAdapter.createFromResource(this, R.array.cleanliness, android.R.layout.simple_spinner_item);
//        Cleanliness1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        Cleanliness.setAdapter(adapter);
    }
}
