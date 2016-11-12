//
//  FlowViewController.swift
//  EcoKitcheniOSHackathon
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let flowNames = ["Refer Enterpreneur","Refer Location","Find Near By Kiosks","About Us","Feedback"];

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = UIView()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowNames.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let flowCell = tableView.dequeueReusableCell(withIdentifier: "flowCell", for: indexPath) as? FlowTableViewCell {
            flowCell.updateUI(flowName: flowNames[indexPath.row]);
            return flowCell;
        }
        return UITableViewCell();
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            performSegue(withIdentifier: "LocationViewController", sender: nil);
        }
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "AboutUsViewController", sender: nil);
        }
        else if indexPath.row == 4 {
            performSegue(withIdentifier: "FeedbackViewController", sender: nil);
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
