//
//  Theme.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/13/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit
extension UIColor {
    class var mainColor: UIColor {
        return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    class var customBackgroundColor: UIColor {
        return UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    }
    
    class var subtitleTextColor: UIColor {
        return UIColor(red: 193.0/255.0, green: 193.0/255.0, blue: 191.0/255.0, alpha: 1.0)
    }
    
    class var headlineTextColor: UIColor {
        return UIColor(red: 120.0/255.0, green: 125.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    }
    
    class var subviewColor: UIColor {
        return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    
    class var navigationBarTextColor: UIColor {
        return UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    }
    
    class var markerBlueColor: UIColor {
        return UIColor(red: 46.0/255.0, green: 168.0/255.0, blue: 216.0/255.0, alpha: 1.0)
    }
    
    class var eventViewColor: UIColor {
        return UIColor(red: 46.0/255.0, green: 168.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    }
    
    class var contactViewColor: UIColor {
        return UIColor(red: 248.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    
    
    // message screen colors
    
    class var messageSubjectColor: UIColor {
        return UIColor(red: 53.0/255.0, green: 56.0/255.0, blue: 61.0/255.0, alpha: 1.0)
    }
    
    class var messageDetailColor: UIColor {
        return UIColor(red: 106.0/255.0, green: 106.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    }
    
    class var messageDateColor: UIColor {
        return UIColor(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }
    
}
// MARK:- UIFont Extensions
extension UIFont {
    class var standardTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 15)!
    }
    
    class var toolBarTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 9)!
    }
    
    class var iPhone6HighScaleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 17)!
    }
    
    class var iPhone6HighScaleSubTitleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 15)!
    }
    
    class var iPhone6PlusHighScaleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 20)!
    }
    
    class var iPhone6PlusHighScaleSubTitleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 17)!
    }
    
    class var iPhone5TextFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 13)!
    }
    
    class var iPhone6TextFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 15)!
    }
    
    class var iPhone6PlusTextFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 17)!
    }
    
    class var titleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 15)!
    }
    
    class var boldTitleTextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 15)!
    }
    
    class var subTitle1TextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 13)!
    }
    
    class var subTitle2TextFont: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 12)!
    }
    
    // Nag Messages
    
    class var iPhone6PlusNagTitleFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 22)!
    }
    
    class var iPhone6PlusNagMessageFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 20)!
    }
    
    class var iPhone6NagTitleFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 20)!
    }
    
    class var iPhone6NagMessageFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 18)!
    }
    
    class var iPhone5NagTitleFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 17)!
    }
    
    class var iPhone5NagMessageFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 15)!
    }
    
    class var iPhone4NagTitleFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 16)!
    }
    
    class var iPhone4NagMessageFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 15)!
    }
}
// MARK:- UINavigationBar Extensions
extension UINavigationBar {
    
    class func styleForNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.mainColor
        UINavigationBar.appearance().tintColor = UIColor.navigationBarTextColor
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:
            UIFont.standardTextFont,  NSForegroundColorAttributeName: UIColor.navigationBarTextColor]
    }
}
// MARK:- UIToolbar Extensions
extension UIToolbar {
    
    class func styleForToolbar() {
        UIToolbar.appearance().barTintColor = UIColor.mainColor
        UIToolbar.appearance().tintColor = UIColor.mainColor
    }
}
// MARK:- Apply Theme
func applyTheme() {
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = UIColor.mainColor
    sharedApplication.statusBarStyle = UIStatusBarStyle.lightContent
    UINavigationBar.styleForNavigationBar()
    UIToolbar.styleForToolbar()
}

