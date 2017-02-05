//
//  MotivationsViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class MotivationsViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  let motivationsDataSourse = MotivationsDataSource()
  
  let webservice = Webservice()
  
  var allMotivations: Resource<[Motivation]> = try! Resource(
    url: URL(string: "https://motivetica.com/parse/classes/Motivation")!,
    parseKey: "results",
    parseElement: Motivation.init)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.dataSource = motivationsDataSourse
      collectionView.delegate = self
      
      webservice.load(allMotivations) { result in
        print(result)
        self.motivationsDataSourse.motivations = result.value!
        self.collectionView.reloadData()
      }
      
      let cellWidth = UIScreen.main.bounds.size.width
      let cellHeight = UIScreen.main.bounds.size.height - 20
      let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
      
      
    }

  
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//    
//    let numberOfCell: CGFloat = 1   //you need to give a type as CGFloat
//    let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
//    return CGSize(width: cellWidth, height: cellWidth)
//    
//  }
  
  @IBAction func unwindFromEdit(_ sender: UIStoryboardSegue){
    
    print("Back from Edit")
    
  }


}

extension MotivationsViewController : UICollectionViewDelegate {
  
  
  
  
  

}
