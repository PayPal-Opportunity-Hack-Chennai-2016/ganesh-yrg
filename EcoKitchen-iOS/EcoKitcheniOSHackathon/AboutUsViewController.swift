//
//  AboutUsViewController.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/13/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var imagEView: UIImageView!
    @IBOutlet weak var aboutUSLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUSLabel.sizeToFit();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
