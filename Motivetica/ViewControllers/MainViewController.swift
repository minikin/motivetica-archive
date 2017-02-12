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
  var motivations = [Motivation]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: .reachabilityDidChangeNotificationName, object: nil)
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
        webservice.load(Motivation.all) { results in
//          print(results)
          guard let r = results.value else { return }
          self.motivations = r
        }
      } else {
        // Show message
      }
    }
  
  func reachabilityDidChange(_ notification: Notification) {
    checkReachability()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "toPublicMotovations" {
      let destinationController = segue.destination as! MotivationsViewController
      destinationController.motivations = motivations
    } else {
      // Do nothing
    }
    
  }
  
  
  @IBAction func toPublicMotivations(_ sender: UIButton) {
    
  }
  
  @IBAction func toYourOwnMotivations(_ sender: UIButton) {
    
  }
  
  
  @IBAction func unwindFromAbout(_ sender: UIStoryboardSegue){
    print("Back from About. Do nothing")
  }
  
  @IBAction func unwindFromMotivations(_ sender: UIStoryboardSegue){
    print("Back from Motivations.Do nothing.")
  }
  
  
}

