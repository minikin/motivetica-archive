//
//  MainViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 11/7/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
  var motiveticaServerKeys = [String:String]()
  
  var allMoti: Resource<[Motivation]> = try! Resource(
    url: URL(string: "https://motivetica.com/parse/classes/Motivation")!,
    parseElement: Motivation.init)
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
      
      _ = reachability?.startNotifier()
      

//      if let url = Bundle.main.url(forResource:"MotiveticaKeys", withExtension: "plist") {
//        do {
//          let data = try Data(contentsOf:url)
//          motiveticaServerKeys = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:String]
//
//          
//          let serverURL  = motiveticaServerKeys["PARSE_SERVER_URL"].flatMap{ return (string: $0)}
//          let serverMasterKey = motiveticaServerKeys["PARSE_SERVER_MASTER_KEY"].flatMap{ return (string: $0)}
//          let serverRESTKey = motiveticaServerKeys["PARSE_SERVER_REST_API_KEY"].flatMap{ return (string: $0)}
//          let appID = motiveticaServerKeys["PARSE_SERVER_APPLICATION_ID"].flatMap{ return (string: $0)}
//          
//          
//          
//          print("serverURL:", serverURL, serverMasterKey, appID, serverRESTKey)
//          
//        } catch {
//          print(error)
//        }
//      }
//      
      
      let webservice = Webservice()
      let cachedWebservice = CachedWebservice(webservice)
      cachedWebservice.load(allMoti) { result in
        print(result)
      }
      
      
    }

    deinit {
      NotificationCenter.default.removeObserver(self)
      reachability?.stopNotifier()
    }
  
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      checkReachability()
    }
    
    func checkReachability() {
      guard let r = reachability else { return }
      if r.isReachable  {
        view.backgroundColor = UIColor.green
      } else {
        view.backgroundColor = UIColor.red
      }
    }
  
    func reachabilityDidChange(_ notification: Notification) {
      checkReachability()
    }
}
