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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        print(mobileNumber.text!);
        print(password.text!);
        performSegue(withIdentifier: "ProfileViewController", sender: nil);
    }

    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
    }
    
}

