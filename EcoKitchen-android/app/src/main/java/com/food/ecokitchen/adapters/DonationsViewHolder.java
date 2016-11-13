package com.food.ecokitchen.adapters;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.food.ecokitchen.R;
import com.food.ecokitchen.utils.OnItemClickListener;

/**
 * Created by Ramakrishna on 12/08/2015.
 */


public class DonationsViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener{
    public TextView txtDetails,txtDistance,txtAddress;
    OnItemClickListener clickListener;

    public DonationsViewHolder(View itemView,OnItemClickListener itemClickListener) {
        super(itemView);

        txtAddress = (TextView) itemView.findViewById(R.id.txt_address);
        txtDetails = (TextView) itemView.findViewById(R.id.txt_details);
        txtDistance = (TextView) itemView.findViewById(R.id.txt_distance);

        itemView.setOnClickListener(this);
        clickListener = itemClickListener;

    }

    @Override
    public void onClick(View v) {
        clickListener.onItemClick(v, getLayoutPosition());
    }
}

