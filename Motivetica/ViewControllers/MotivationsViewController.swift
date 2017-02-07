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
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let index = scrollView.contentOffset.x / collectionLayout.itemSize.width
    let fracPart = index.truncatingRemainder(dividingBy: 1)
    let item = Int(fracPart >= 0.5 ? ceil(index) : floor(index))
    
    let indexPath = IndexPath(item: item, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
  }

  
  @IBAction func unwindFromEdit(_ sender: UIStoryboardSegue){
    print("Back from Edit")
  }
  

}


extension MotivationsViewController : UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    print("DO SOMETHING")
  }
  
}
