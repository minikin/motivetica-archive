//
//  MainViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 11/7/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import UIKit
import Foundation
import GSMessages

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
          guard let r = results.value else { return }
          self.motivations = r
        }
      } else {
        // Show message
        self.showMessage("No Internet connection", type: .warning, options: [
          .animation(.fade),
          .autoHide(true),
          .autoHideDelay(10.0),
          .height(30.0),
          .hideOnTap(true),
          .position(.top),
          .textAlignment(.center),
          .textColor(UIColor.white),
          .textNumberOfLines(1),
          .textPadding(30.0)
          ])
      }
    }
  
  func reachabilityDidChange(_ notification: Notification) {
    checkReachability()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "toPublicMotivations" {
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

