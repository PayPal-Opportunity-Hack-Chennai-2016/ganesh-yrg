//
//  FlowTableViewCell.swift
//  EcoKitcheniOSHackathon
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class FlowTableViewCell: UITableViewCell {

    @IBOutlet weak var flowLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI(flowName : String){
        flowLabel.text = flowName;
    }

}
