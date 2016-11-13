//
//  FeedbackTableViewController.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var sectionHeader:NSMutableArray = NSMutableArray()
    var dict: NSMutableDictionary = NSMutableDictionary()
    var collapse:NSMutableArray = NSMutableArray()
    var collapseRows:NSMutableArray = NSMutableArray()
    var formData:NSMutableArray = NSMutableArray()
    
    var locationObject : Location?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard));
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap);
        collapse = [false,false,false,false,false,false]
        collapseRows = [false,false,false,false,false,false]
        formData = ["","","","","",""];
        sectionHeader = ["Courtesy of Entrepeneur","Quality of Food","Quantity of Food","Food Taste","Cleanliness of serving","Others"]
        let tmp: NSArray = ["Excellent","Good","Average","Need To Improve"]
        let str = sectionHeader.object(at: 0) as! String
        dict.setValue(tmp, forKey: str)
        
        let str1 = sectionHeader.object(at: 1) as! String
        dict.setValue(tmp, forKey: str1)

        
        let tmp2: NSArray = ["Sufficient","Can be increased"]
        let str2 = sectionHeader.object(at: 2) as! String
        dict.setValue(tmp2, forKey: str2)

        let str3 = sectionHeader.object(at: 3) as! String
        dict.setValue(tmp, forKey: str3)
        
        let str4 = sectionHeader.object(at: 4) as! String
        dict.setValue(tmp, forKey: str4)
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundView = UIImageView(image: UIImage(named: "gradient_searchbar"));
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    func ratingCalc(rating : String) -> Int {
        if rating == "Excellent"{
            return 5
        }
        else if rating == "Good"{
            return 4
        }
        else if rating == "Average"{
            return 3
        }
        else if rating == "Need To Improve"{
            return 2
        }
        else {
            return 1
        }
        
    }
    
    
    @IBAction func submitBtnPressed(_ sender: AnyObject) {
        print(formData)
        let serviceManager = ServiceManager()
        let feedback = Feedback()
        feedback.locationId = GLOBAL_USERID
        feedback.userId = GLOBAL_USERID
        feedback.courtesy = ratingCalc(rating: formData[0] as! String);
        feedback.qualityOfFood = ratingCalc(rating: formData[1] as! String);
        feedback.quantityOfFood = ratingCalc(rating: formData[2] as! String);
        feedback.foodTaste = ratingCalc(rating: formData[3] as! String);
        feedback.cleanliness = ratingCalc(rating: formData[4] as! String);
        feedback.content = formData[5] as! String
        serviceManager.updateFeedback(feedback: feedback) { (success) in
            if(success != -1) {
                print("Successfully feedback")
            } else {
                //show Alert
            }
        }
        
    }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "";
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = collapse.object(at: section) as! Bool
        if value == true {
            if section != 5{
                let sectionHeaderTitle = sectionHeader.object(at: section) as! String
                let arr = dict.value(forKey: sectionHeaderTitle) as! NSArray
                return arr.count
            }
            else if section == 5 {
                return 1;
            }
        }
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 5 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell"){
                cell.textLabel?.text = .none
                
                let country = sectionHeader.object(at: indexPath.section) as! String
                let arr = dict.value(forKey: country) as! NSArray
                cell.textLabel?.text = arr.object(at: indexPath.row) as? String
                cell.textLabel?.sizeToFit();
            //    cell.textLabel?.textColor = UIColor.white
                cell.textLabel?.font = UIFont(name: "Courier New", size: 18)

                cell.selectionStyle = UITableViewCellSelectionStyle.none;
                cell.viewWithTag(100)?.isHidden = true
                cell.backgroundView = UIImageView(image: UIImage(named: "gradient_searchbar"));
                return cell
            }
        }
        else if indexPath.section == 5 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell"){
                let headerTextview = UITextView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
                headerTextview.text = "Please specify"
                headerTextview.font = UIFont(name: "Courier New", size: 18)
                headerTextview.tag = 100;
                cell.addSubview(headerTextview)
                cell.textLabel?.font = UIFont(name: "Courier New", size: 18)
                cell.backgroundView = UIImageView(image: UIImage(named: "gradient_searchbar"));
                cell.selectionStyle = UITableViewCellSelectionStyle.none;
                return cell
            }
        }
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let val = collapseRows.object(at: section) as! Bool
        if val == false
        {
            return 60
        }
        return 80
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = collapse.object(at: indexPath.section) as! Bool
        if value == true
        {
            return UITableViewAutomaticDimension
        }
        return UITableViewAutomaticDimension
    }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.tag = section
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let image = UIImage(named: "gradient_searchbar")
        imageView.image = image
        headerView.addSubview(imageView)
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = sectionHeader[section] as? String
        headerString.font = UIFont(name: "Courier New", size: 21)
        headerString.textColor = UIColor.white
        
        let headerStringDetailLabel = UILabel(frame: CGRect(x: 10, y: 40, width: tableView.frame.size.width-10, height: 40)) as UILabel
        headerStringDetailLabel.text = formData[section] as? String
        headerStringDetailLabel.font = UIFont(name: "Courier", size: 16)
        let collapseRowsVal = collapseRows.object(at: section) as! Bool
        if collapseRowsVal == false {
            headerStringDetailLabel.isHidden = true
        }
        headerStringDetailLabel.tag = 200 + section
        
        let headerButton = UIButton()
        let val = collapse.object(at: section) as! Bool
        if val == false
        {
            headerButton.setTitle("+", for: .normal)
        }
        else
        {
            headerButton.setTitle("-", for: .normal)
        }
        headerButton.setTitleColor(UIColor.blue, for: .normal)
        headerButton.tag = section
        headerButton.frame = CGRect(x:tableView.frame.size.width-60,y:5,width:30,height:40)
        headerButton.addTarget(self, action: #selector(FeedbackViewController.headerTapped), for: .touchUpInside)
        headerView.addSubview(headerString)
        headerView.addSubview(headerButton)
        headerView.addSubview(headerStringDetailLabel)
        return headerView
    }
    
    func headerTapped(sender: UIButton!)
    {
        setEditing(false, animated: true)
        print("Tapping")
        print(sender.tag)
        let indexPath : NSIndexPath = NSIndexPath(row: 0, section: sender.tag)
        
        var valCollapse = collapseRows.object(at: indexPath.section) as! Bool
        valCollapse = false
        collapseRows.replaceObject(at: indexPath.section, with: valCollapse)
        
        var val = collapse.object(at: indexPath.section) as! Bool
        val = !val
        collapse.replaceObject(at: indexPath.section, with: val)
        for i in 0..<collapse.count
        {
            if i != indexPath.section
            {
                collapse.replaceObject(at: i, with: false)
                
            }
        }
        tableView.reloadData();
    }
    
    
    func dismissKeyboard(){
        self.view.endEditing(true);
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        print("Selected row");
        let country = sectionHeader.object(at: indexPath.section) as! String
        if indexPath.section != 5 {
        let arr = dict.value(forKey: country) as! NSArray
        let headerView = self.view.viewWithTag(0)
        let headerDetailLabel = headerView?.viewWithTag(200+indexPath.section) as? UILabel
        headerDetailLabel?.text = arr.object(at: indexPath.row) as? String;
        headerDetailLabel?.isHidden = false;
        formData[indexPath.section] = arr.object(at: indexPath.row) as? String;
        //   let indexPath = tableView.indexPathForSelectedRow!
     //   let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
      //  cell.detailTextLabel?.text = arr.object(at: indexPath.row) as? String
       // cell.detailTextLabel?.sizeToFit();
      //  tableView.reloadData()
        }
        var val = collapseRows.object(at: indexPath.section) as! Bool
        val = true
        collapseRows.replaceObject(at: indexPath.section, with: val)
//        for i in 0..<collapseRows.count
//        {
//            if i != indexPath.section
//            {
//                collapseRows.replaceObject(at: i, with: false)
//                
//            }
//        }
        
        var value = collapse.object(at: indexPath.section) as! Bool
        value = !value
        collapse.replaceObject(at: indexPath.section, with: value)
        for i in 0..<collapse.count
        {
            if i != indexPath.section
            {
                collapse.replaceObject(at: i, with: false)
                
            }
        }
        
        let range = NSMakeRange(indexPath.section,1)
        let sectionReload = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sectionReload as IndexSet, with: UITableViewRowAnimation.fade)
        tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.none)
    }
    
    @IBAction func exitSelectKiosk(segue: UIStoryboardSegue) {
        let controller = segue.source as? SelectKioskTableViewController
        let location = controller?.selectionLocation
        self.locationObject = location!
        navigationItem.title = location?.address
    }

}
