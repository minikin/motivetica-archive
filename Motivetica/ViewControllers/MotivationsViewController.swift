//
//  MotivationsViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit
import Hue

class MotivationsViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var motivations = [Motivation]()
  var motivationsDataSourse = ItemsDataSource(items:[Motivation](), cellDescriptor:{ $0.cellDescriptor })

  override func viewDidLoad() {
      super.viewDidLoad()
    
    collectionView.dataSource = motivationsDataSourse
    collectionView.delegate = self
  
    let cellWidth = UIScreen.main.bounds.size.width
    let cellHeight = UIScreen.main.bounds.size.height - 20
    let layout = collectionView.collectionViewLayout as! MotivationsLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
        
    motivationsDataSourse.items = motivations
    collectionView.dataSource = motivationsDataSourse
    collectionView.reloadData()
  }

  @IBAction func unwindFromEdit(_ sender: UIStoryboardSegue){
    print("Back from Edit.Set changes here!")
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let index = scrollView.contentOffset.x / collectionLayout.itemSize.width
    let fracPart = index.truncatingRemainder(dividingBy: 1)
    let item = Int(fracPart >= 0.5 ? ceil(index) : floor(index))
    
    let indexPath = IndexPath(item: item, section: 0)
    self.view.backgroundColor = UIColor(hex: motivations[indexPath.row].backgroundColor)
    
    print(motivations[indexPath.row].backgroundColor)
  }

}

extension MotivationsViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    print("DO SOMETHING")
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
  }
}

