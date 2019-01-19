//
//  HomeViewController.swift
//  JTSOfficeSwift
//
//  Created by Jochebed Tech Mac Mini 1 on 23/02/17.
//  Copyright © 2017 Jochebed Tech Mac Mini 1. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ssidName: String?
    var url: String?
    //var urlint: String?
   // var urlext: String?
//    var chechdataurlint: Bool?
//    var chechdataurlext: Bool?
    var username: String?
    var password: String?

    @IBOutlet var tabelViewData: UITableView!
    var myArray : [String] = [String()]
     var myArray1 : [String] = [String()]
    @IBOutlet var segmentVarable: UISegmentedControl!
    @IBOutlet var labeljts: UILabel!
    
    @IBOutlet var buttlabel: UIButton!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        
        
        let defaults12 = UserDefaults.standard
        username = defaults12.value(forKey: "username") as? String
        let defaults13 = UserDefaults.standard
        password = defaults13.value(forKey: "password") as? String
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async{
            
            self.labeljts.text="Jochebed Tech Solutions"
            self.buttlabel.setTitle("Logout", for: .normal)
        
        let attr = NSDictionary(object: UIFont(name: "Helvetica", size: 16.0)!, forKey: NSFontAttributeName as NSCopying)
        self.segmentVarable.setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
//        getRoomDetails()
//        
//        getGroupSwitches()
        segmentVarable.selectedSegmentIndex=0
        tabelViewData.backgroundColor=UIColor.clear
        
        if segmentVarable.selectedSegmentIndex==0{

        getRoomDetails()
        }
        tabelViewData.delegate=self
        
        tabelViewData.dataSource=self
        tabelViewData.reloadData()
  
    }
    
    
    func didBecomeActive() {
        print("did become active home")
        
       // reachNetwork();
        
    }
    
    func willEnterForeground() {
        print("will enter foreground")
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
       // reachNetwork();
     print(" view appere is this")
  
    }
    
    
//
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
            print("Connected via WWAN......")
            chechdataurlint=false
            
            if (UserDefaults.standard.object(forKey: "externalip") != nil){
                
                print("came in")
                
                let defaults12 = UserDefaults.standard
                let externalip = defaults12.value(forKey: "externalip")
                
                urlext=(externalip as! String)
                
                chechdataurlint=false
                chechdataurlext=true
                
                
                
                
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
                            
                            chechdataurlint=true
                            chechdataurlext=false
                        }
                        else{
                            
                            print("ssid not match")
                            
                            chechdataurlint=false
                            
                            chechdataurlext=true
                            
                            if (UserDefaults.standard.object(forKey: "externalip") != nil){
                                
                                let defaults12 = UserDefaults.standard
                                let externalip = defaults12.value(forKey: "externalip")
                                
                                urlext=(externalip as! String)
                                
                                chechdataurlext=true
                                chechdataurlint=false
                    
                            }
                            
                            
                        }
     
                    }
                        
                    else{
                        if (UserDefaults.standard.object(forKey: "externalip") != nil){
                            
                            let defaults12 = UserDefaults.standard
                            let externalip = defaults12.value(forKey: "externalip")
                            
                            urlext=(externalip as! String)
                            
                            chechdataurlext=true
                            chechdataurlint=false
                        }else{
                            
//                            let alert = UIAlertController(title: "Network ", message: "Plese enter settings IP's.", preferredStyle: UIAlertControllerStyle.alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    break
                }
            }
        }
        //  return ssid
        
        
        
        
        if segmentVarable.selectedSegmentIndex==0{
            getRoomDetails()
            //getFrequnetSwitches()
           // tabelViewData.reloadData()
             //getGroupSwitches()
            
            
        }
        
        
        
//        tabelViewData.delegate=self
//        
//        tabelViewData.dataSource=self
      //   tabelViewData.reloadData()
        
        
        
    }
    


    @IBAction func segmentAction(_ sender: Any) {
        
        if segmentVarable.selectedSegmentIndex==0{
            
            
           getRoomDetails()
            
            segmentVarable.setEnabled(false, forSegmentAt: 1)
            segmentVarable.setEnabled(false, forSegmentAt: 2)
            segmentVarable.setEnabled(false, forSegmentAt: 3)

            
            
        }
        if segmentVarable.selectedSegmentIndex==1{
            
                           getFrequnetSwitches()
            
            segmentVarable.setEnabled(false, forSegmentAt: 0)
            segmentVarable.setEnabled(false, forSegmentAt: 2)
            segmentVarable.setEnabled(false, forSegmentAt: 3)

            
        }
        if segmentVarable.selectedSegmentIndex==2{
            
                      getGroupSwitches()
            segmentVarable.setEnabled(false, forSegmentAt: 0)
            segmentVarable.setEnabled(false, forSegmentAt: 1)
            segmentVarable.setEnabled(false, forSegmentAt: 3)

            
        }
        if segmentVarable.selectedSegmentIndex==3{
            
            getCollectiveSws()
            segmentVarable.setEnabled(false, forSegmentAt: 0)
            segmentVarable.setEnabled(false, forSegmentAt: 1)
            segmentVarable.setEnabled(false, forSegmentAt: 2)

            
        }

        
        
     tabelViewData.reloadData()
        
    }
    
    
    
    func getGroupSwitches(){
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/get_group_switches_by_room"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/get_group_switches_by_room"
            
        }
        
        
        
        
        print("this is url \(url!)")
        
        
        
        
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = "POST"
        
        let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"room_id\": \"\"}"
        
        print(postString)
        // let postString = "id=13&name=Jack"
        
        
        DispatchQueue.main.async(){
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("getGroupSwitches  ######### = \(responseString!)")
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let name = json["error_code"] as? String
                let comp = "3"
                
                if name==comp{
                    print("no datafound")
                    let alert = UIAlertController(title: "Groups", message: "No Switches added", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                     DispatchQueue.main.async{
                        
                        
                    self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                    self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                    self.segmentVarable.setEnabled(true, forSegmentAt: 3)
                    
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            var teamId : [String] = [String()]
              var teamId1 : [String] = [String()]
            //   let teamId2 : String = roomlabel.text!
            
            
            do {
                // let  data : NSData = NSData() // change your data variable as you get from webservice response
                guard let teamJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let liquidLocations = teamJSON["group_switch_details"] as? [[String: Any]]
                    else { return }
                
                
               
                
                
                
                
                //looping through all the json objects in the array teams
                for i in 0 ..< liquidLocations.count{
                    teamId+=[ (liquidLocations[i]["switch_name"] as! NSString) as String]
               // if [ (liquidLocations[i]["room_id"] as! NSString) as String].contains(teamId2){

                    teamId1+=[ (liquidLocations[i]["switch_id"] as! NSString) as String]
                    //                       // print("this is inside data of switch : \(teamId1)")
                    //
                    //                    }
                    
                    
                    // print(teamId)
                    //  print(teamId1)
                    
                }
                var dataArray = Array(teamId)
                print("this is after loop of string \(teamId)")
                print("this is after loop of array \(dataArray)")
                dataArray.remove(at: 0)
                
                var dataArray1 = Array(teamId1)
                print("this is after loop of string \(teamId1)")
                print("this is after loop of array \(dataArray1)")
                dataArray1.remove(at: 0)
                
                //                dataArray = dataArray.filter(){$0 != "COMMON_JTS"}
                //
                //                dataArray = dataArray.filter(){$0 != "UNKNOWN_ROOM"}
                print("this is after remove of array 77777777 \(dataArray1)")
                
                print(dataArray.count)
                print(dataArray1.count)
                
                //dataArray=dataArray.sorted{$0 < $1}
                //dataArray1=dataArray1.sorted{$0 < $1}
                
                let defaults21 = UserDefaults.standard
                defaults21.set(dataArray, forKey: "groupSwitch_Array")
                let defaults22 = UserDefaults.standard
                defaults22.set(dataArray1, forKey: "groupSwitch_Array_id")

                DispatchQueue.main.async{
                    self.tabelViewData.reloadData()
                }
                
             
                
                
            } catch {
                print(error)
            }
            
            
          //  groupSwitch_Array
            
            
            
            
            
        }
        task.resume()
        
        }
        
    //    tabelViewData.reloadData()

        
    }
    

    
    
    func getFrequnetSwitches(){
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/get_most_active_switches"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/get_most_active_switches"
            
        }
        
        
        
        
        print("this is url \(url!)")
        

        
        
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = "POST"
        
        let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\"}"
        
        print(postString)
        // let postString = "id=13&name=Jack"
        
        DispatchQueue.main.async(){
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                
                let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                self.segmentVarable.setEnabled(true, forSegmentAt: 3)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("getFrequnetSwitches $$$$$$$$$$$$ = \(responseString!)")
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let name = json["error_code"] as? String
                let comp = "3"
                
                if name==comp{
                    print("no datafound")
                    let alert = UIAlertController(title: "Frequnet", message: "No Switches added", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.async{
                        
                        
                        self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                        self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                        self.segmentVarable.setEnabled(true, forSegmentAt: 3)
                        
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            var teamId : [String] = [String()]
            var teamId1 : [String] = [String()]
            var teamId2 : [String] = [String()]
            //   let teamId2 : String = roomlabel.text!
            
            
            do {
                // let  data : NSData = NSData() // change your data variable as you get from webservice response
                guard let teamJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let liquidLocations = teamJSON["most_active_sw_details"] as? [[String: Any]]
                    else { return }
                
                
                
                
                //looping through all the json objects in the array teams
                for i in 0 ..< liquidLocations.count{
                    if [ (liquidLocations[i]["room_id"] as! NSString) as String] == [ (liquidLocations[i]["room_id"] as! NSString) as String]{
                    teamId+=[ (liquidLocations[i]["switch_name"] as! NSString) as String]
                    teamId1+=[ (liquidLocations[i]["switch_id"] as! NSString) as String]
                        teamId2+=[ (liquidLocations[i]["switch_status"] as! NSString) as String]

                   
                       
                        
                    }
                   
                    
                }
                var dataArray = Array(teamId)
                print("this is after loop of string \(teamId)")
                print("this is after loop of array \(dataArray)")
                dataArray.remove(at: 0)
                print("this is after remove of array 6666666666 \(dataArray)")
                
                
                
                
                
                
                
                
                var dataArray1 = Array(teamId1)
                print("this is after loop of string \(teamId1)")
                print("this is after loop of array \(dataArray1)")
                dataArray1.remove(at: 0)
                print("this is after remove of array 6666666666 \(dataArray1)")
                
                
                var dataArray2 = Array(teamId2)
                print("this is after loop of string \(teamId2)")
                print("this is after loop of array \(dataArray2)")
                dataArray2.remove(at: 0)
                print("this is after remove of array 6666666666 \(dataArray2)")

                
                
                let defaults21 = UserDefaults.standard
                defaults21.set(dataArray, forKey: "frequentSwitch_Array")
                let defaults22 = UserDefaults.standard
                defaults22.set(dataArray1, forKey: "frequentSwitch_Array_id")

                let defaults23 = UserDefaults.standard
                defaults23.set(dataArray2, forKey: "frequentSwitch_Status")
                
               // self.tabelViewData.reloadData()
                
                
                DispatchQueue.main.async{
                   self.tabelViewData.reloadData()
                }
                
                
            } catch {
                print(error)
            }
            
            
            
            
            
            
            
        }
        task.resume()
          //  self.tabelViewData.reloadData()
            
        }
        
//        tabelViewData.delegate=self
//        
//        tabelViewData.dataSource=self

        

        
        
        
        
        
       

        
    }

    
    
    
    
    func getRoomDetails(){
        
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/get_room"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/get_room"
            
        }
        
        
        
        
        print("this is url \(url!)")
        
        
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = "POST"
        
        let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\"}"
        
        print(postString)
        // let postString = "id=13&name=Jack"
        
        
        DispatchQueue.main.async(){
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                
                let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                self.segmentVarable.setEnabled(true, forSegmentAt: 3)
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString from rooms in home = \(responseString!)")
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let name = json["error_code"] as? String
                let comp = "3"
                
                if name==comp{
                    print("no datafound")
                    let alert = UIAlertController(title: "Rooms", message: "No Switches added", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.async{
                        
                        
                        self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                        self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                        self.segmentVarable.setEnabled(true, forSegmentAt: 3)
                        
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            var teamId : [String] = [String()]
            var teamId1 : [String] = [String()]
         //   let teamId2 : String = roomlabel.text!
            
            
            do {
                // let  data : NSData = NSData() // change your data variable as you get from webservice response
                guard let teamJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let liquidLocations = teamJSON["room_details"] as? [[String: Any]]
                    else { return }
                
                //looping through all the json objects in the array teams
                for i in 0 ..< liquidLocations.count{
//                    if [ (liquidLocations[i]["room_id"] as! NSString) as String]=="COMMON_JTS" && [ (liquidLocations[i]["room_id"] as! NSString) as String] {
//
//                        print("not adding")
//
//                    }else{
//
                    
                    teamId+=[ (liquidLocations[i]["room_id"] as! NSString) as String]
                    teamId1+=[ (liquidLocations[i]["description"] as! NSString) as String]
                   // }

//                    if [ (liquidLocations[i]["room_id"] as! NSString) as String].contains(teamId2){
//                        
//                        teamId1+=[ (liquidLocations[i]["switch_id"] as! NSString) as String]
//                       // print("this is inside data of switch : \(teamId1)")
//                        
//                    }
                    
                    
                   // print(teamId)
                  //  print(teamId1)
                    
                }
                var dataArray = Array(teamId)
                var dataArray1 = Array(teamId1)
                print("this is after loop of string \(teamId)")
                 print("this is after loop of string \(teamId1)")
                print("this is after loop of array \(dataArray)")
                print("this is after loop of array \(dataArray1)")
                dataArray.remove(at: 0)
                 dataArray1.remove(at: 0)
                let index1=dataArray.index(of: "COMMON_JTS")
                dataArray.remove(at: Int(index1!))
                dataArray1.remove(at: Int(index1!))
                let index2=dataArray.index(of: "UNKNOWN_ROOM")
                print("indes are \((index1!)) and \(index2!)")
                
                dataArray.remove(at: Int(index2!))
                dataArray1.remove(at: Int(index2!))
               /// dataArray = dataArray.filter(){$0 != "COMMON_JTS"}
                
               // dataArray = dataArray.filter(){$0 != "UNKNOWN_ROOM"}
               // print("this is after remove of array 55555555555 \(dataArray)")
                
                
                
                
               
                
               
                
                
                
                
                //dataArray1 = dataArray1.filter(){$0 != "used for common switches"}
                
               // dataArray1 = dataArray1.filter(){$0 != "UNKNOWN_ROOM used as temp place holder for ref constraints"}
               // print("this is after remove of array 55555555555 \(dataArray1)")
                
                
                
                
               //  print(uniq(dataArray))
                // let dedupe = removeDuplicates(array: dataArray)
            //     print(dedupe)

                
//                var unique = Array(Set(dataArray))
//
//                print(unique)
//                print(unique.count)
//                unique=unique.sorted{$0 < $1}

                let defaults11 = UserDefaults.standard
               defaults11.set(dataArray, forKey: "roomName_Array")
                
                
//                var unique1 = Array(Set(dataArray1))
//
//                print(unique1)
//                print(unique1.count)
//                unique1=unique1.sorted{$0 < $1}
                
                let defaults12 = UserDefaults.standard
                defaults12.set(dataArray1, forKey: "roomDesc_Array")
                
                
                print("this is final array  :: \(dataArray)")
                print("this is final array 1 :: \(dataArray1)")

                
                DispatchQueue.main.async{
                    self.tabelViewData.reloadData()
                }
                
                
                
                
                
                
                
            } catch {
                print(error)
            }
            

            
            
            
            
            
            
        }
        task.resume()
        }
        

//        tabelViewData.delegate=self
//        
//        tabelViewData.dataSource=self
        
        

        
    }
    
    
    func getCollectiveSws()
    {
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/get_collective_switches_by_room"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/get_collective_switches_by_room"
            
        }
        
        
        
        
        print("this is url \(url!)")
        
        
        
        
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = "POST"
        
        let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"room_id\": \"\"}"
        
        print(postString)
        // let postString = "id=13&name=Jack"
        
        DispatchQueue.main.async(){
            
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    
                    let alert = UIAlertController(title: "NetWork Error", message: "Host Not Reachable Please Chack", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                    self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                    self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                    self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                    
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("getFrequnetSwitches $$$$$$$$$$$$ = \(responseString!)")
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    
                    let name = json["error_code"] as? String
                    let comp = "3"
                    
                    if name==comp{
                        print("no datafound")
                        let alert = UIAlertController(title: "Collective", message: "No Switches added", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        DispatchQueue.main.async{
                            
                            
                            self.segmentVarable.setEnabled(true, forSegmentAt: 0)
                            self.segmentVarable.setEnabled(true, forSegmentAt: 1)
                            self.segmentVarable.setEnabled(true, forSegmentAt: 2)
                            
                        }
                    }
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                
                
                
                var teamId : [String] = [String()]
                var teamId1 : [String] = [String()]
                // var teamId2 : [String] = [String()]
                //   let teamId2 : String = roomlabel.text!
                
                
                do {
                    // let  data : NSData = NSData() // change your data variable as you get from webservice response
                    guard let teamJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                        let liquidLocations = teamJSON["collective_switch_details"] as? [[String: Any]]
                        else { return }
                    
                    //looping through all the json objects in the array teams
                    for i in 0 ..< liquidLocations.count{
                        //if [ (liquidLocations[i]["room_id"] as! NSString) as String] == [ (liquidLocations[i]["room_id"] as! NSString) as String]{
                        teamId+=[ (liquidLocations[i]["switch_name"] as! NSString) as String]
                        teamId1+=[ (liquidLocations[i]["switch_id"] as! NSString) as String]
                        // teamId2+=[ (liquidLocations[i]["switch_status"] as! NSString) as String]
                        
                        
                        
                        
                        //  }
                        
                        
                    }
                    var dataArray = Array(teamId)
                    //     print("this is after loop of string \(teamId)")
                    //    print("this is after loop of array \(dataArray)")
                    dataArray.remove(at: 0)
                    print("this is after remove of array 6666666666 \(dataArray)")
                    
                    
                    
                    
                    
                    
                    
                    
                    var dataArray1 = Array(teamId1)
                    //  print("this is after loop of string \(teamId1)")
                    //  print("this is after loop of array \(dataArray1)")
                    dataArray1.remove(at: 0)
                    print("this is after remove of array 6666666666 \(dataArray1)")
                    
                    
                    //                    var dataArray2 = Array(teamId2)
                    //                    // print("this is after loop of string \(teamId2)")
                    //                    // print("this is after loop of array \(dataArray2)")
                    //                    dataArray2.remove(at: 0)
                    //                    // print("this is after remove of array 6666666666 \(dataArray2)")
                    //
                    
                    
                    let defaults21 = UserDefaults.standard
                    defaults21.set(dataArray, forKey: "collective_Array")
                    let defaults22 = UserDefaults.standard
                    defaults22.set(dataArray1, forKey: "collective_Array_id")
                    
                    //                    let defaults23 = UserDefaults.standard
                    //                    defaults23.set(dataArray2, forKey: "frequentSwitch_Status")
                    //
                    // self.tabelViewData.reloadData()
                    
                    
                    DispatchQueue.main.async{
                        self.tabelViewData.reloadData()
                    }
                    
                    
                } catch {
                    print(error)
                }
                
                
                
                
                
                
                
            }
            task.resume()
            //  self.tabelViewData.reloadData()
            
        }
        
        //        tabelViewData.delegate=self
        //
        //        tabelViewData.dataSource=self
        
        
        
        
        
        
        
        
        
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonOperation(_ sender: UIButton){
        
//        print("dsfasdf %i",sender.tag);
//        
//        let defaults1 = UserDefaults.standard
//        let myArray1 = defaults1.stringArray(forKey: "groupSwitch_Array_id") ?? [String]()
//        
//        var request = URLRequest(url: URL(string: "https://jtsha.in/service/device")!)
//        request.httpMethod = "POST"
//        
//        let postString="{\"username\": \"mahesh\", \"password\": \"mahesh12babu\",\"switch_id\":\"\(myArray1[sender.tag])\"}"
//       
//        
//        print(postString)
//        // let postString = "id=13&name=Jack"
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(String(describing: error))")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(String(describing: response))")
//            }
//            
//            let responseString = String(data: data, encoding: .utf8)
//            print("getGroupSwitches  ######### = \(responseString!)")
//            
//            
//        }
//        task.resume()
//
        
        
    }
    @IBAction func switchOperation(_ sender: UISwitch){
        
        
        
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/device"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/device"
            
        }
        
        
        print("this is url \(url!)")
        
        
        
         print("%i",sender.tag);
        let defaults1 = UserDefaults.standard
        let myArray1 = defaults1.stringArray(forKey: "frequentSwitch_Array_id") ?? [String]()
        let defaults2 = UserDefaults.standard
        var myarray2 = defaults2.stringArray(forKey: "frequentSwitch_Status") ?? [String]()
        
        if sender.isOn{
            print("this is on")
            myarray2[(sender as AnyObject).tag] = "1"
            
            let defaults22 = UserDefaults.standard
            defaults22.set(myarray2, forKey: "frequentSwitch_Status")
            print("response\(myarray2) ")
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[sender.tag])\",\"operation\":\"ON\"}"
            
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
            defaults22.set(myarray2, forKey: "frequentSwitch_Status")
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[sender.tag])\",\"operation\":\"OFF\"}"
            
            print(postString)
            // let postString = "id=13&name=Jack"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
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
    
    
    @IBAction func collectiveSwitchOperation(_ sender: UISwitch){
        
        
        
        
        
        if chechdataurlint==true{
            
            url="http://\(urlint!)/service/device"
            
        }
        
        if chechdataurlext==true{
            
            url="https://\(urlext!)/service/device"
            
        }
        
        
        print("this is url \(url!)")
        
        
        
        print("%i",sender.tag);
        let defaults1 = UserDefaults.standard
        let myArray1 = defaults1.stringArray(forKey: "collective_Array_id") ?? [String]()
        let defaults = UserDefaults.standard
        let myArray = defaults.stringArray(forKey: "collective_Array") ?? [String]()
        
       
        
        print(" this is room array :\(myArray)")
        if sender.isOn{
            print("this is on")
            
           
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[sender.tag])\",\"operation\":\"ON\"}"
            
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
                print("response string is  = \(responseString!)")
                
                
                
                
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    
                    let name = json["error_code"] as? String
                    let comp = "0"
                    
                    print(" this sis error code \(name!)")
                    
                    
                    
                    if name == comp {
                        
                        print("opreation perfomred success fully")
                        
                        
                        
                        
                    }
                    else{
                        
                        print("opreation filed")
                        
                        
                        
                        
                        
                    }
                }
                    
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                
                
                
                
                
                
            }
            task.resume()
        }
        else{
            print("this is Off")
           
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[sender.tag])\",\"operation\":\"OFF\"}"
            
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
                print("response Stings is  = \(responseString!)")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    
                    let name = json["error_code"] as? String
                    let comp = "0"
                    
                    print(" this sis error code \(name!)")
                    
                    
                    
                    if name == comp {
                        
                        print("opreation perfomred success fully")
                        
                        
                        
                        
                    }
                    else{
                        
                        print("opreation filed")
                        
                        
                        
                        
                    }
                }
                    
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                
                
                
                
                
                
            }
            task.resume()
        }
    }

    
    
    @IBAction func logout1(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
//    func logout(_ sender: Any) {
//        
//        self.dismiss(animated: true, completion: nil)
//        
//    }
//    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentVarable.selectedSegmentIndex==0{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "roomDesc_Array") ?? [String]()
        }
        if segmentVarable.selectedSegmentIndex==1{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "frequentSwitch_Array") ?? [String]()
        }
        if segmentVarable.selectedSegmentIndex==2{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "groupSwitch_Array") ?? [String]()
        }
        if segmentVarable.selectedSegmentIndex==3{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "collective_Array") ?? [String]()
        }

        return myArray.count
    }
    
    var valueToPass:String?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("You selected cell #\(indexPath.row)!")
        
        if segmentVarable.selectedSegmentIndex==0{
            
            DispatchQueue.main.async(){
            
            // Get Cell Label
           // let indexPath = tableView.indexPathForSelectedRow!
           // let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            
               // print(currentCell)
               // print(indexPath)
                
                let defaults = UserDefaults.standard
                self.myArray = defaults.stringArray(forKey: "roomName_Array") ?? [String]()
                print(self.myArray[indexPath.row])
                
                
                let defaults1 = UserDefaults.standard
                let roomaArray = defaults1.stringArray(forKey: "roomDesc_Array") ?? [String]()
                
            //self.valueToPass = currentCell.textLabel?.text
            //print(self.valueToPass!)
            
            let MainStrory:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let viewController = MainStrory.instantiateViewController(withIdentifier: "data2") as!SecondRoomViewController
            viewController.label1=self.myArray[indexPath.row]
                viewController.label2=roomaArray[indexPath.row]

            self.present(viewController, animated: true, completion: nil)
            }
            
        }
        
        
         if segmentVarable.selectedSegmentIndex==2{
            
         
            if chechdataurlint==true{
                
                url="http://\(urlint!)/service/device"
                
            }
            
            if chechdataurlext==true{
                
                url="https://\(urlext!)/service/device"
                
            }
            
            
            print("this is url \(url!)")
            
            
            
            
            
            print("dsfasdf %i",indexPath.row);
            
            let defaults1 = UserDefaults.standard
            let myArray1 = defaults1.stringArray(forKey: "groupSwitch_Array_id") ?? [String]()
            
            var request = URLRequest(url: URL(string: url!)!)
            request.httpMethod = "POST"
            
            let postString="{\"username\": \"\(username!)\", \"password\": \"\(password!)\",\"switch_id\":\"\(myArray1[indexPath.row])\"}"
            
            
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
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.backgroundColor=UIColor.init(white: 0.5, alpha: 0.5)
        cell.selectionStyle = .none
        cell.textLabel?.textColor=UIColor.init(white: 1.0, alpha: 1.0)
      cell.textLabel?.font=UIFont.boldSystemFont(ofSize: 16)
       cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds=true
        
        
        
        
        
       
        
        
        
        
        
        if segmentVarable.selectedSegmentIndex==0{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "roomDesc_Array") ?? [String]()
           // let defaults1 = UserDefaults.standard
        //   let myArray1 = defaults1.stringArray(forKey: "roomName_Array_id") ?? [String]()
            
            cell.textLabel?.text=myArray[indexPath.row]
            cell.accessoryType = .disclosureIndicator
                // cell.detailTextLabel?.text=myArray1[indexPath.row]
            segmentVarable.setEnabled(true, forSegmentAt: 1)
            segmentVarable.setEnabled(true, forSegmentAt: 2)
            segmentVarable.setEnabled(true, forSegmentAt: 3)

            
        }
        if segmentVarable.selectedSegmentIndex==1{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "frequentSwitch_Array") ?? [String]()
            
//            let defaults1 = UserDefaults.standard
//            let myArray1 = defaults1.stringArray(forKey: "frequentSwitch_Array_id") ?? [String]()
            
            
            let defaults2 = UserDefaults.standard
            myArray1 = defaults2.stringArray(forKey: "frequentSwitch_Status") ?? [String]()
            
            cell.textLabel?.text=myArray[indexPath.row]
           // cell.detailTextLabel?.text=myArray1[indexPath.row]
            
           // cell.textLabel?.text="mahesh"
            let switchDemo:UISwitch=UISwitch(frame:CGRect(x: 0, y: 0, width: 20, height: 20));
            //
            
            
            
            if (myArray1[indexPath.row]) == "0"{
                switchDemo.isOn=false
                
            }
            else{
                
                switchDemo.isOn=true
                
            }

            
            
            //switchDemo.isOn = false
            // switchDemo.setOn(true, animated: false);
            switchDemo.tag=indexPath.row
            
            switchDemo.restorationIdentifier = "\(indexPath.row)"
            
            switchDemo.addTarget(self, action: #selector(HomeViewController.switchOperation(_:)), for: .valueChanged);
            //self.view.addSubview(switchDemo);
            //cell.accessoryType=UISwitch
            cell.accessoryView=switchDemo

            
            
            
            //cell.textLabel?.text="babu"
            segmentVarable.setEnabled(true, forSegmentAt: 0)
            segmentVarable.setEnabled(true, forSegmentAt: 2)
            segmentVarable.setEnabled(true, forSegmentAt: 3)


            
        }
        if segmentVarable.selectedSegmentIndex==2{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "groupSwitch_Array") ?? [String]()
            
            
            cell.textLabel?.text=myArray[indexPath.row]
            
            cell.textLabel?.textAlignment = NSTextAlignment.right
            
//            let buttonDemo:UIButton=UIButton(frame:CGRect(x: 0, y: 0, width: 80, height: 30));
//          
//            buttonDemo.backgroundColor=UIColor.green
//            buttonDemo.tag=indexPath.row
//            buttonDemo.setTitle("Touch", for: .normal)
//            
//            buttonDemo.restorationIdentifier = "\(indexPath.row)"
//            
//              buttonDemo.addTarget(self, action: #selector(HomeViewController.buttonOperation(_:)), for: .touchUpInside);
//            //self.view.addSubview(switchDemo);
//            //cell.accessoryType=UISwitch
//            cell.accessoryView=buttonDemo

            
            
            segmentVarable.setEnabled(true, forSegmentAt: 0)
            segmentVarable.setEnabled(true, forSegmentAt: 1)
            segmentVarable.setEnabled(true, forSegmentAt: 3)
            
           
                
            
            

            
        }
        
        
        
        
        if segmentVarable.selectedSegmentIndex==3{
            
            let defaults = UserDefaults.standard
            myArray = defaults.stringArray(forKey: "collective_Array") ?? [String]()
            
            //            let defaults1 = UserDefaults.standard
            //            let myArray1 = defaults1.stringArray(forKey: "frequentSwitch_Array_id") ?? [String]()
            
            
            //            let defaults2 = UserDefaults.standard
            //            myArray1 = defaults2.stringArray(forKey: "frequentSwitch_Status") ?? [String]()
            
            cell.textLabel?.text=myArray[indexPath.row]
            // cell.detailTextLabel?.text=myArray1[indexPath.row]
            
            // cell.textLabel?.text="mahesh"
            let switchDemo1:UISwitch=UISwitch(frame:CGRect(x: 0, y: 0, width: 20, height: 20));
            //
            switchDemo1.isOn=false
            
            
            //            if (myArray1[indexPath.row]) == "0"{
            //                switchDemo.isOn=false
            //
            //            }
            //            else{
            //
            //                switchDemo.isOn=true
            //
            //            }
            
            
            
            //switchDemo.isOn = false
            // switchDemo.setOn(true, animated: false);
            switchDemo1.tag=indexPath.row
            
            switchDemo1.restorationIdentifier = "\(indexPath.row)"
            
            switchDemo1.addTarget(self, action: #selector(HomeViewController.collectiveSwitchOperation(_:)), for: .valueChanged);
            //self.view.addSubview(switchDemo);
            //cell.accessoryType=UISwitch
            cell.accessoryView=switchDemo1
            
            
            
            
            //cell.textLabel?.text="babu"
            segmentVarable.setEnabled(true, forSegmentAt: 0)
            segmentVarable.setEnabled(true, forSegmentAt: 2)
            segmentVarable.setEnabled(true, forSegmentAt: 1)
            
           
            
            
            
        }

        
        
        
        
     //cell.detailTextLabel?.text="hai"
    
        return cell
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







