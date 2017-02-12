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
  
}

extension MotivationsViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    print("DO SOMETHING")
  }
  
}

extension MotivationsViewController: UICollectionViewDelegateFlowLayout {
  

  
  
  
  
}

