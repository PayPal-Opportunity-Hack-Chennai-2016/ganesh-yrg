//
//  RefEntrepreneurViewController.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/13/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit

class RefEntrepreneurViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {

    var sectionHeader:NSMutableArray = NSMutableArray()
    var dict: NSMutableDictionary = NSMutableDictionary()
    var collapse:NSMutableArray = NSMutableArray()
    var collapseRows:NSMutableArray = NSMutableArray()
    var formData:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var mobileNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RefEntrepreneurViewController.dismissKeyboard));
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap);
        collapse = [false,false,false,false]
        collapseRows = [false,false,false,false]
        formData = ["","","","",""];
        sectionHeader = ["Gender","Marital Status","Income Range","Educational Qualification"]
        let tmp: NSArray = ["Male","Female","TransGender"]
        let str = sectionHeader.object(at: 0) as! String
        dict.setValue(tmp, forKey: str)
        
        let tmp2: NSArray = ["Single","Married","Seperated","Divorced"]
        let str1 = sectionHeader.object(at: 1) as! String
        dict.setValue(tmp2, forKey: str1)
        
        
        let tmp3: NSArray = ["less than 5000","less than 10000","less than 20000","greater than 20000"]
        let str2 = sectionHeader.object(at: 2) as! String
        dict.setValue(tmp3, forKey: str2)
        
        let tmp4: NSArray = ["Primary","Middle","Matric/SSLC","HSLC/PUC/Intermediate","Graduate and above","Illiterate"]
        let str3 = sectionHeader.object(at: 3) as! String
        dict.setValue(tmp4, forKey: str3)
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundView = UIImageView(image: UIImage(named: "gradient_searchbar"));
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        let image = UIImage(named: "gradient_searchbar")
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        mobileNumberTextField.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
    }
    
    @IBAction func submitBtnPressed(_ sender: AnyObject) {
        let serviceManager = ServiceManager()
        let refEnterpreneur = RefEnterpreneur()
        refEnterpreneur.name = nameTextField.text
        refEnterpreneur.phone = mobileNumberTextField.text
        refEnterpreneur.incomeRange = formData[2] as! String
        refEnterpreneur.maritalStatus = formData[1] as! String
        refEnterpreneur.qualificaiton = formData[3] as! String
        refEnterpreneur.gender = formData[0] as! String
        serviceManager.updateRefEntrepreneur(refEntreprenuer: refEnterpreneur) { (success) in
            if (success != -1) {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Refer Entrepreneur Success", message:  "Thank You for your referral.", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }

            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Refer Entrepreneur Failure", message:  "Did not meet requirements", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
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
                let sectionHeaderTitle = sectionHeader.object(at: section) as! String
                let arr = dict.value(forKey: sectionHeaderTitle) as! NSArray
                return arr.count
            }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Entrepreneurcell"){
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
        headerButton.setTitleColor(UIColor.white, for: .normal)
        headerButton.tag = section
        headerButton.frame = CGRect(x:tableView.frame.size.width-50,y:5,width:30,height:40)
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
    
    
    
    
   /* func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        var section = 0;
        if (tag == 500) {
            formData[0] = textField.text;
            section = 0;
        } else if(tag == 501) {
            formData[1] = textField.text;
            section = 1;
        } else {
            formData[6] = textField.text;
            section = 6;
        }
        textField.resignFirstResponder()
        var val = collapseRows.object(at: section) as! Bool
        val = true
        collapseRows.replaceObject(at: section, with: val)
        
        var value = collapse.object(at: section) as! Bool
        value = !value
        collapse.replaceObject(at: section, with: value)
        for i in 0..<collapse.count
        {
            if i != section
            {
                collapse.replaceObject(at: i, with: false)
                
            }
        }
        
        let range = NSMakeRange(section,1)
        let sectionReload = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sectionReload as IndexSet, with: UITableViewRowAnimation.fade)
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: UITableViewRowAnimation.none)

    }*/
    
}
