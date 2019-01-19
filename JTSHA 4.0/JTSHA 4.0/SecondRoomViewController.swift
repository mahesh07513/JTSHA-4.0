//
//  SecondRoomViewController.swift
//  JTSOfficeSwift
//
//  Created by Jochebed Tech Mac Mini 1 on 21/04/17.
//  Copyright © 2017 Jochebed Tech Mac Mini 1. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class SecondRoomViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var image: UIImageView!
    
//    var ssidName: String?
//    var url: String?
//    var urlint: String?
//    var urlext: String?
//    var chechdataurlint: Bool?
//    var chechdataurlext: Bool?
    var username: String?
    var password: String?
    //var url1: String?

      var myArray : [String] = [String()]
    @IBOutlet var secondTable: UITableView!
    
    var nodata: Bool?

    
    @IBOutlet var backVar: UIButton!
    
    @IBOutlet var roomlabel: UILabel!
    var label1=String()
    var label2=String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
               //getRoomSwitchs()

        roomlabel.text = label2

        nodata=false
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let defaults12 = UserDefaults.standard
        username = defaults12.value(forKey: "username") as? String
        let defaults13 = UserDefaults.standard
        password = defaults13.value(forKey: "password") as? String
        
        print("this is username and password \(String(describing: username!))::::\(String(describing: password!))")
        
//
//        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
//
//
//        NotificationCenter.default.addObserver(self, selector: #selector(SecondRoomViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
//        Reach().monitorReachabilityChanges()
//
//
        
        
      //  reachNetwork()
        
        getRoomSwitchs()
        secondTable.backgroundColor=UIColor.clear
        
        
        
        
        secondTable.dataSource=self
        secondTable.delegate=self
        secondTable.reloadData()

    }
    
    
    
    func didBecomeActive() {
        print("did become active second")
        
       // reachNetwork();
        
    }
    
    func willEnterForeground() {
        print("will enter foreground")
        
        
    }
    
    
    
    
    
//    func networkStatusChanged(_ notification: Notification) {
//        let userInfo = (notification as NSNotification).userInfo
//        print("kdslkkkkk :\(userInfo!)")
//
//        reachNetwork();
//    }
//
    
    func reachNetwork(){
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            
            let alert = UIAlertController(title: "Network ", message: "Plese Switch ON your Mobile Data(or)WiFi.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
        case .online(.wwan):
            print("Connected via WWAN")
            
            if (UserDefaults.standard.object(forKey: "externalip") != nil){
                
                let defaults12 = UserDefaults.standard
                let externalip = defaults12.value(forKey: "externalip")
                
                urlext=(externalip as! String)
                
                chechdataurlint=false
                chechdataurlext=true
                
                getRoomSwitchs()
                
                
                
                
            }else{
                
                let alert = UIAlertController(title: "Settings ", message: "Plese enter External IP in Register Page.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
            
            
        case .online(.wiFi):
            print("Connected via WiFi")
            
            getSSID()
            
        }
        
    }
    
    
    func getSSID()  {
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssidName = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    
                    print(ssidName!)
                    
                    
                    
                    
                    if (UserDefaults.standard.object(forKey: "internalip") != nil) && (UserDefaults.standard.object(forKey: "ssid") != nil){
                        
                        
                        
                        let defaults12 = UserDefaults.standard
                        let internalip = defaults12.value(forKey: "internalip")
                        
                        
                        let defaults13 = UserDefaults.standard
                        let ssidsettings = defaults13.value(forKey: "ssid") as! String?
                        
                        
                        if (ssidsettings == ssidName) {
                            
                            print("ssid is match")
                            
                            urlint=(internalip as! String)
                            
                            
                            url="http://\(urlint!)/service/get_device"
                            
                            
                            chechdataurlint=true
                            chechdataurlext=false
                            
                            
                            //roomlabel.text
                            
                            loadImageFromUrl(url: "http://\(urlint!)/images/\(label1).jpg", view: image)
                      
                            
                            getRoomSwitchs()
                            
                          
                            
                        }
                        else{
                            
                            print("ssid not match")
                            
                            chechdataurlint=false
                            
                            chechdataurlext=true
                            
                            if (UserDefaults.standard.object(forKey: "externalip") != nil){
                                
                                let defaults12 = UserDefaults.standard
                                let externalip = defaults12.value(forKey: "externalip")
                                
                                urlext=(externalip as! String)
                                
                                
                                url="https://\(urlext!)/service/get_device"
                                
                                chechdataurlint=false
                                chechdataurlext=true
                                
                                loadImageFromUrl(url: "https://\(urlext!)/images/\(label1).jpg", view: image)
                                
                                getRoomSwitchs()


                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
                        
                    else{
                        
                        chechdataurlint=false
                        
                        if (UserDefaults.standard.object(forKey: "externalip") != nil){
                            
                            let defaults12 = UserDefaults.standard
                            let externalip = defaults12.value(forKey: "externalip")
                            
                            urlext=(externalip as! String)
                            
                            url="https://\(urlext!)/service/get_device"
                            
                            chechdataurlint=false
                            chechdataurlext=true
                            loadImageFromUrl(url: "https://\(urlext!)/images/\(label1).jpg", view: image)
                            
                            getRoomSwitchs()
                        }else{
                            
                            let alert = UIAlertController(title: "Settings ", message: "Plese enter settings IP's.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    
                
                    
                    
                    
                    
                    
                    
                    break
                }
            }
        }
        //  return ssid
    }

    
    
    
    
   func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                    
                    if(view.image == nil){
                   print("252525252525252525252525")
                        self.image.image=UIImage(named:"47810436-a45b-406f-ba31-cf89d0b6a2e9.jpg")
  
                    }else{
                        print(" image is there")
                    }
                })
            }
        }
        
        // Run task
        task.resume()
    }
        @IBAction func sampleSwitchValueChanged01(_ sender: Any) {
        
        
        
        
        
                if chechdataurlint==true{
        
                   url="http://\(urlint!)/service/device"
        
                }
        
                if chechdataurlext==true{
        
                     url="https://\(urlext!)/service/device"
        
                }
        
        
        
        
        print("this is url \(url!)")
 
        
        print("%i",(sender as AnyObject).tag);
        let defaults1 = UserDefaults.standard
        let myArray1 = defaults1.stringArray(forKey: "SavedStringArray01") ?? [String]()
        let defaults2 = UserDefaults.standard
        var myarray2 = defaults2.stringArray(forKey: "SavedStringArray02") ?? [String]()
        
        if (sender as AnyObject).isOn{
            print("this is on")
            myarray2[(sender as AnyObject).tag] = "1"
            
            let defaults22 = UserDefaults.standard
            defaults22.set(myarray2, forKey: "SavedStringArray02")
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[(sender as AnyObject).tag])\",\"operation\":\"ON\"}"
            
            print(postString)
            // let postString = "id=13&name=Jack"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    
                    let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("getGroupSwitches  ######### = \(responseString!)")
            }
            task.resume()
        }
        else{
            print("this is Off")
            myarray2[(sender as AnyObject).tag] = "0"
            let defaults22 = UserDefaults.standard
            defaults22.set(myarray2, forKey: "SavedStringArray02")
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[(sender as AnyObject).tag])\",\"operation\":\"OFF\"}"
            
            print(postString)
            // let postString = "id=13&name=Jack"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    
                    let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                    
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("getGroupSwitches  ######### = \(responseString!)")
                
                
            }
            task.resume()
        }
        
    }

    
    
    func getRoomSwitchs(){
        
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/get_device"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/get_device"
            
        }
        
        print("this is url \(url!)")
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = "POST"
        
        let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"room_id\": \"\(label1)\"}"
        
        print(postString)
        // let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                
                let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let name = json["error_code"] as? String
                let comp = "3"
                
                if name==comp{
                    print("no datafound")
                    let alert = UIAlertController(title: self.label1, message: "No Switches added", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   self.nodata=false
                    
                  
                    
                }else{
                    
                    self.nodata=true
                    
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
           // var teamId2 : String = String()
//            DispatchQueue.main.async{
//                teamId2 = self.roomlabel.text!
//            }
            
            if self.nodata==true{
            
            var teamId : [String] = [String()]
            var teamId1 : [String] = [String()]
            var teamId3 : [String] = [String()]
            var teamId4 : [String] = [String()]
            
            
            do {
                // let  data : NSData = NSData() // change your data variable as you get from webservice response
                guard let teamJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let liquidLocations = teamJSON["device_details"] as? [[String: Any]]
                    else { return }
                
                //looping through all the json objects in the array teams
                for i in 0 ..< liquidLocations.count{
                    teamId+=[ (liquidLocations[i]["room_id"] as! NSString) as String]
                    
                  //  if [ (liquidLocations[i]["room_id"] as! NSString) as String].contains(teamId2){
                        
                        teamId1+=[ (liquidLocations[i]["switch_id"] as! NSString) as String]
                        // print("this is inside data of switch : \(teamId1)")
                        teamId3+=[ (liquidLocations[i]["switch_status"] as! NSString) as String]
                        teamId4+=[ (liquidLocations[i]["switch_name"] as! NSString) as String]
                        
                   // }
                }
                // room
                var dataArray = Array(teamId)
                dataArray.remove(at: 0)
                
                print("this is after remove of array \(dataArray)")

                //switch id
                var dataArray1 = Array(teamId1)
                //   print("this is after loop of string \(teamId1)")
                //  print("this is after loop of array \(dataArray1)")
                dataArray1.remove(at: 0)
                
                print("this is after remove of array \(dataArray1)")
                
                let defaults21 = UserDefaults.standard
                defaults21.set(dataArray1, forKey: "SavedStringArray01")
                
                
                //switch status
                var dataArray2 = Array(teamId3)
                //   print("this is after loop of string \(teamId1)")
                //  print("this is after loop of array \(dataArray1)")
                dataArray2.remove(at: 0)
                
                print("this is after remove of array \(dataArray2)")
                
                let defaults22 = UserDefaults.standard
                defaults22.set(dataArray2, forKey: "SavedStringArray02")
                
                
                //switch name
                
                
                self.myArray = Array(teamId4)
                //   print("this is after loop of string \(teamId1)")
                //  print("this is after loop of array \(dataArray1)")
                self.myArray.remove(at: 0)
                
                print("this is after remove of array \(self.myArray)")
                
                let defaults23 = UserDefaults.standard
                defaults23.set(self.myArray, forKey: "SavedStringArray03")
                
               
                        DispatchQueue.main.async{
                            self.secondTable.reloadData()
                        }
 
                
                
            } catch {
                print(error)
            }
        }
        }
        task.resume()
        
//        DispatchQueue.main.async{
//            self.secondTable.reloadData()
//        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
       let myArray1 = defaults.stringArray(forKey: "SavedStringArray03") ?? [String]()
        return myArray1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        
        
        cell.backgroundColor=UIColor.init(white: 0.5, alpha: 0.5)
        
        
        if self.nodata==true{
            let defaults = UserDefaults.standard
            let myarray21 = defaults.stringArray(forKey: "SavedStringArray03") ?? [String]()
            //print("45454545454545454545454545454:\(myArray)")
            
            
            
            cell.selectionStyle = .none
            cell.textLabel?.textColor=UIColor.init(white: 1.0, alpha: 1.0)
            cell.textLabel?.font=UIFont.boldSystemFont(ofSize: 16)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds=true

                let defaults2 = UserDefaults.standard
                let myarray2 = defaults2.stringArray(forKey: "SavedStringArray02") ?? [String]()
                //cell.textLabel?.text="mahesh"
        
                cell.textLabel?.text=myarray21[indexPath.row]
        
                let switchDemo:UISwitch=UISwitch(frame:CGRect(x: 0, y: 0, width: 20, height: 20));
               // switchDemo.isOn = false
        
                if (myarray2[indexPath.row]) == "1"{
                    switchDemo.isOn=true
        
                }
                else{
                    
        
                    switchDemo.isOn=false
        
                }
        
        
                // switchDemo.setOn(true, animated: false);
                switchDemo.tag=indexPath.row
        
                switchDemo.restorationIdentifier = "\(indexPath.row)"
                
                switchDemo.addTarget(self, action: #selector(SecondRoomViewController.sampleSwitchValueChanged01(_:)), for: .valueChanged);
                //self.view.addSubview(switchDemo);
                //cell.accessoryType=UISwitch
                cell.accessoryView=switchDemo
        }
        
        return cell
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
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
