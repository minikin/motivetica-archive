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
  @IBOutlet var mainView: UIView!
  
  var motivations = [Motivation]()
  var motivationsDataSourse = ItemsDataSource(items:[Motivation](), cellDescriptor:{ $0.cellDescriptor })

  override func viewDidLoad() {
      super.viewDidLoad()
    
    motivationsCollectionView.dataSource = motivationsDataSourse
    motivationsCollectionView.delegate = self
  
    let cellWidth = UIScreen.main.bounds.size.width
    let cellHeight = UIScreen.main.bounds.size.height - footerView.frame.height - CGFloat(Space.betweenFooter.rawValue)
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

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    let motivation = motivations[indexPath.row]
    
    footerView.backgroundColor = UIColor(hex: motivation.backgroundColor)
    
    fontName.text = motivation.fontType
    fontName.font = UIFont(name: motivation.fontType, size: 16.0)
    fontName.textColor = UIColor(hex: motivation.fontColor)
    
    fontWeight.text = motivation.fontWeight
    fontWeight.font = UIFont(name: motivation.fontType, size: 12.0)
    fontWeight.textColor = UIColor(hex: motivation.fontColor)

    
    //    cell.fontName.text = fontType
    //    cell.fontName.font =  UIFont(name: fontType, size: 16.0)
    //    cell.fontName.textColor = UIColor(hex: fontColor)
    //    cell.fontWeight.text = fontWeight
    //    cell.fontWeight.font = UIFont(name: fontType, size: 12.0)
    //    cell.fontWeight.textColor = UIColor(hex: fontColor)
  }



}

