//
//  IntroViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 2/26/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit
import Foundation

class IntroViewController: UIViewController {
  
  @IBOutlet weak var dash: UIImageView!
  @IBOutlet weak var mLetter: UIImageView!
  @IBOutlet weak var oLetter: UIImageView!
  @IBOutlet weak var t1Letter: UIImageView!
  @IBOutlet weak var i1Letter: UIImageView!
  @IBOutlet weak var vLetter: UIImageView!
  @IBOutlet weak var eLetter: UIImageView!
  @IBOutlet weak var t2Letter: UIImageView!
  @IBOutlet weak var i2Letter: UIImageView!
  @IBOutlet weak var cLetter: UIImageView!
  @IBOutlet weak var aLetter: UIImageView!
  
  var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
  let webservice = Webservice()
  var motivations = [Motivation]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    motiveticaAnimation()
    

  }
  
  
  // MARK: - Animation
  
  func blinkDashWith(_ image:UIImageView){
    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
      UIView.setAnimationRepeatCount(3)
      self.dash.alpha = 0.0
    }, completion: { (finished: Bool) -> Void in
        image.alpha = 1.0
    })
  }
  
  func motiveticaAnimation () {
    
    mLetter.alpha = 0
    oLetter.alpha = 0
    t1Letter.alpha = 0
    i1Letter.alpha = 0
    vLetter.alpha = 0
    eLetter.alpha = 0
    t2Letter.alpha = 0
    i2Letter.alpha = 0
    cLetter.alpha = 0
    aLetter.alpha = 0
    

    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [], animations: {
    
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8, animations: {
        self.blinkDashWith(self.mLetter)
        
      })
    

    

    })
    
    
    
    
    
    
//    let alphaChange = UIViewPropertyAnimator(duration: 2, curve: .easeIn, animations: { [weak self] in
//      self?.dash.alpha = 0
//    })
//    
//    
//    alphaChange.startAnimation()
    
  }



}
