//
//  SettingsViewController.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 02/10/20.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var rateUsView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        let defaults = UserDefaults.standard
        if (defaults.bool(forKey: "darkMode") == true) {
            darkModeSwitch.setOn(true, animated: true)
        } else {
            darkModeSwitch.setOn(false, animated: true)
        }
        rateUsView.isUserInteractionEnabled = true
        shareView.isUserInteractionEnabled = true
        
        rateUsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateUsTapped)))
        shareView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareTapped)))
    }
    
    @objc func rateUsTapped() {
        print("Rate Us Tapped")
        if let url = URL(string: "https://apps.apple.com/us/app/id1534481981")
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
    @objc func shareTapped() {
        let someText:String = "Create beautiful countdowns"
        let objectsToShare:URL = URL(string: "https://apps.apple.com/us/app/id1534481981")!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        
        if darkModeSwitch.isOn {
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: "darkMode")
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "darkMode")
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    @objc func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
