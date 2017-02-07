//
//  MainViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 11/7/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
  
  var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
  let webservice = Webservice()

  var allMotivations: Resource<[Motivation]> = try! Resource(
    url: URL(string: "https://motivetica.com/parse/classes/Motivation")!,
    parseKey: "results",
    parseElement: Motivation.init)
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
      _ = reachability?.startNotifier()
      
          
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
        webservice.load(allMotivations) { result in
          print(result)
        }
      } else {
        view.backgroundColor = UIColor.red
      }
    }
  
    func reachabilityDidChange(_ notification: Notification) {
      checkReachability()
    }
  
  
  @IBAction func unwindFromAbout(_ sender: UIStoryboardSegue){
    
    print("Back from About")
    
  }
  
  @IBAction func unwindFromMotivations(_ sender: UIStoryboardSegue){
    
    print("Back from Motivations")
    
  }
  
  
}

