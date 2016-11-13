package com.food.ecokitchen.actvities;

import android.content.Context;
import android.os.Bundle;
import android.os.StrictMode;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import com.food.ecokitchen.R;
import com.food.ecokitchen.adapters.ChatArrayAdapter;

import java.util.HashMap;

import ai.api.AIConfiguration;
import ai.api.AIDataService;
import ai.api.AIServiceException;
import ai.api.model.AIError;
import ai.api.model.AIRequest;
import ai.api.model.AIResponse;
import ai.api.model.Fulfillment;
import ai.api.model.Result;
import ai.api.ui.AIDialog;

public class ChatBotMainActivity extends AppCompatActivity implements AIDialog.AIDialogListener{

    String str="";
    private ChatArrayAdapter chatArrayAdapter;
    boolean side = false,flag=true;
    EditText et;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.chatbotactivitylayout);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        final ActionBar ab = getSupportActionBar();
        //ab.setHomeAsUpIndicator(R.mipma);
        ab.setDisplayHomeAsUpEnabled(true);

        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        et=(EditText)findViewById(R.id.msg);

        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        Button send=(Button)findViewById(R.id.send);
        ListView chatTextView=(ListView)findViewById(R.id.msgview);

        final AIConfiguration config = new AIConfiguration("1342cd9f9ef94af59fb45000900dc660", AIConfiguration.SupportedLanguages.English,
                AIConfiguration.RecognitionEngine.System);
        Context context=this;

        final AIDataService aiDataService = new AIDataService(context,config);

        chatArrayAdapter=new ChatArrayAdapter(context,R.id.msgview);

        final ChatboxNew cb=new ChatboxNew(send,et,chatTextView,getApplicationContext());
        if(flag==true) {
            cb.sendChatMessage("");//to make the input shift sides on the screen
            flag = false;
        }

        send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                AIRequest req=(new AIRequest());
                AIResponse resp=new AIResponse();

                try {
                    HashMap hash;

                    req.setQuery(String.valueOf(et.getText()));//setting the query
                    cb.sendChatMessage(String.valueOf(et.getText()));//Printing on the chat interface

                    final AIResponse response = aiDataService.request(req);
                    Result result=new Result();
                    result=response.getResult();
                    Fulfillment full=result.getFulfillment();
                    str=full.getSpeech();//This is the speech output
                    cb.sendChatMessage(str);//Output is printed on the chat interface
                    et.setText("");

                } catch (AIServiceException e) {
                    e.printStackTrace();
                }
            }
        });

    }



    @Override
    public void onResult(AIResponse result) {

    }

    @Override
    public void onError(AIError error) {

    }

    @Override
    public void onCancelled() {

    }
}
