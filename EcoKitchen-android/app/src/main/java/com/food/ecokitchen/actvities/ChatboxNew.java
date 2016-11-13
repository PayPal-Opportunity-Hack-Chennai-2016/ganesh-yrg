package com.food.ecokitchen.actvities;

import android.app.Activity;
import android.content.Context;
import android.database.DataSetObserver;
import android.view.KeyEvent;
import android.view.View;
import android.widget.AbsListView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import com.food.ecokitchen.R;
import com.food.ecokitchen.adapters.ChatArrayAdapter;
import com.food.ecokitchen.adapters.ChatMessage;


public class ChatboxNew {

    private static final String TAG = "ChatActivity";
    private ListView listView;
    private EditText chatText;
    ChatArrayAdapter chatArrayAdapter;
    private Button buttonSend;
    private boolean side = false;

    ChatboxNew(){

    }
 
    ChatboxNew(Button buttonsend, EditText chattext, ListView listview, Context cont)
    {
        final Button buttonSend=buttonsend;
        final EditText chatText=chattext;
        final ListView listView=listview;
        chatArrayAdapter = new ChatArrayAdapter(cont, R.layout.right);

        listView.setAdapter(chatArrayAdapter);

        chatText.setOnKeyListener(new View.OnKeyListener() {
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if ((event.getAction() == KeyEvent.ACTION_DOWN) && (keyCode == KeyEvent.KEYCODE_ENTER)) {
                    return sendChatMessage(String.valueOf(chatText.getText()));
                }
                return false;
            }
        });
        buttonSend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                sendChatMessage(String.valueOf(chatText.getText()));
            }
        });
 
        listView.setTranscriptMode(AbsListView.TRANSCRIPT_MODE_ALWAYS_SCROLL);
        listView.setAdapter(chatArrayAdapter);
 
        //to scroll the list view to bottom on data change
        chatArrayAdapter.registerDataSetObserver(new DataSetObserver() {
            @Override
            public void onChanged() {
                super.onChanged();
                listView.setSelection(chatArrayAdapter.getCount() - 1);
            }
        });
    }
 
        boolean sendChatMessage(String string) {
        chatArrayAdapter.add(new ChatMessage(side, string));
        //chatText.setText("");
        side = !side;
        return true;
    }
}
