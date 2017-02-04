//
//  AboutViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/30/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }


  @IBAction func openSpiilka(_ sender: UIButton) {
    guard let spiilkaURL = URL(string: "http://spiilka.com") else { return }
    UIApplication.shared.open(spiilkaURL, options: [:], completionHandler: nil)
  }
  
  
  @IBAction func openMinikin(_ sender: UIButton) {
    guard let minikinURL = URL(string: "http://minikin.me") else { return }
    UIApplication.shared.open(minikinURL, options: [:], completionHandler: nil)
  }

}
