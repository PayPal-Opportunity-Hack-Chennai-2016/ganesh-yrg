//
//  ViewController.swift
//  EcoKitcheniOSHackathon
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mobileNumber.text = "8883729793"
        password.text = "echokitchen"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        
        let manager = ServiceManager()
        manager.signIn(mobile: mobileNumber.text!, password: password.text!) { (userId) in
            self.performSegue(withIdentifier: "FlowViewController", sender: nil);
        }

    }

    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "ProfileViewController", sender: nil);
    }
    
}

