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
  
  @IBOutlet weak var motivationsCollectionView: UICollectionView!
  @IBOutlet weak var footerView: UIView!
  @IBOutlet weak var backToHome: UIButton!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var textColor: UIImageView!
  @IBOutlet weak var allignment: UIImageView!
  @IBOutlet weak var fontName: UILabel!
  @IBOutlet weak var fontWeight: UILabel!
  
  var motivations = [Motivation]()
  var motivationsDataSourse = ItemsDataSource(items:[Motivation](), cellDescriptor:{ $0.cellDescriptor })

  override func viewDidLoad() {
      super.viewDidLoad()
    
    motivationsCollectionView.dataSource = motivationsDataSourse
    motivationsCollectionView.delegate = self
  
    let cellWidth = UIScreen.main.bounds.size.width
    let cellHeight = UIScreen.main.bounds.size.height - footerView.frame.height - 8
    let layout = motivationsCollectionView.collectionViewLayout as! MotivationsLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
        
    motivationsDataSourse.items = motivations
    motivationsCollectionView.dataSource = motivationsDataSourse
    motivationsCollectionView.reloadData()
  }

  @IBAction func unwindFromEdit(_ sender: UIStoryboardSegue){
    print("Back from Edit.Set changes here!")
  }

}

extension MotivationsViewController : UICollectionViewDelegate {





}

