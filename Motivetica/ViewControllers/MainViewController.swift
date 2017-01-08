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
//  var reachability = Reachability(hostName: "www.apple.com")

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
        view.backgroundColor = UIColor.green
      } else {
        view.backgroundColor = UIColor.red
      }
    }
  
    func reachabilityDidChange(_ notification: Notification) {
      checkReachability()
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
