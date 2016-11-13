//
//  ViewController.swift
//  EcoKitcheniOSHackathon
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private var responseReceived = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileNumber.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        mobileNumber.text = "9884170853"
        password.text = "Paypal"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        responseReceived = false
        let manager = ServiceManager()
        manager.signIn(mobile: mobileNumber.text!, password: password.text!) { (userId) in
            if userId != -1 {
                self.responseReceived = true
                GLOBAL_USERID = userId
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "FlowViewController", sender: nil);
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Login Failure", message:  "User Id Or Password entered incorrectly", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }

        }

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return responseReceived
    }

    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier:"ProfileViewController" , sender: nil);

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
    }
    
}

