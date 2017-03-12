//
//  AboutViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/30/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  @IBOutlet weak var motiveticaLogo: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Add Gesture Recognizer
    let justTap = UITapGestureRecognizer(target: self, action: #selector(justTap(from:)))
    justTap.numberOfTapsRequired = 1
    motiveticaLogo.addGestureRecognizer(justTap)
  
  }
  
  // Perform transition
  func justTap(from recognizer: UIPanGestureRecognizer) {
  
    performSegue(withIdentifier: "unwindAbout", sender: recognizer)
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
