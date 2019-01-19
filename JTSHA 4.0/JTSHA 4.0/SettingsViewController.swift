//
//  SettingsViewController.swift
//  JTSOfficeSwift
//
//  Created by Jochebed Tech Mac Mini 1 on 02/08/17.
//  Copyright © 2017 Jochebed Tech Mac Mini 1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {
    
    var ipfields = [String]()
    
    @IBOutlet var externalip: UITextField!

    @IBOutlet var internalip: UITextField!
    
    
    @IBOutlet var ssid: UITextField!
    
    
    @IBOutlet var varRegister: UIButton!
    
    
    @IBOutlet var varBack: UIButton!
    @IBAction func Register(_ sender: Any) {
        
        
        
        if externalip .hasText{
            
            print("this is an arry not nil")
            
            let defaults4 = UserDefaults.standard
            defaults4.set(externalip.text, forKey: "externalip")
            
            
        }
            
            
        else{
            print("this is an arry of setting nil")
            
            
            let defaults4 = UserDefaults.standard
            defaults4.removeObject(forKey: "externalip")
        }
        
        
        
        
        if internalip .hasText{
            
            print("this is an arry not nil")
            
            let defaults5 = UserDefaults.standard
            defaults5.set(internalip.text, forKey: "internalip")
            
            
        }
            
            
        else{
            print("this is an arry of setting nil")
            
            
            let defaults5 = UserDefaults.standard
            defaults5.removeObject(forKey: "internalip")
        }
        

        
        
        if ssid .hasText{
            
            print("this is an arry not nil")
            
            let defaults4 = UserDefaults.standard
            defaults4.set(ssid.text, forKey: "ssid")
            
            
        }
            
            
        else{
            print("this is an arry of setting nil")
            
            
            let defaults4 = UserDefaults.standard
            defaults4.removeObject(forKey: "ssid")
        }
        

        
        
        
        
        
        
        
        
        
        
        
       // print("this is an arry of setting  \(ipfields)")
        
        
        
        
        
        
        
        
        
        
        

        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        checkData();
        
    }
    
    
    
     func checkData(){
        
        if (UserDefaults.standard.object(forKey: "externalip") != nil){
            
            let defaults12 = UserDefaults.standard
            let uname1 = defaults12.value(forKey: "externalip")
            externalip.text=uname1 as? String
            
            
        }else{
            
            print("external ip nil")
        }
        
        
        if (UserDefaults.standard.object(forKey: "internalip") != nil){
            
            let defaults13 = UserDefaults.standard
            let uname2 = defaults13.value(forKey: "internalip")
            internalip.text=uname2 as? String
            
            
        }else{
            
            print("internalip ip nil")
        }
        
        
        if (UserDefaults.standard.object(forKey: "ssid") != nil){
            
            let defaults14 = UserDefaults.standard
            let uname3 = defaults14.value(forKey: "ssid")
            ssid.text=uname3 as? String
            
            
        }else{
            
            print("ssid ip nil")
        }
        
        
        
        
        
        
        
    }
    
    
    @IBAction func Back(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        externalip.delegate=self
        internalip.delegate=self
        ssid.delegate=self

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
