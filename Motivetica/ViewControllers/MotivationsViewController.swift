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
  var fakeMotivations = [Motivation]()
  var motivationsDataSourse = ItemsDataSource(items:[Motivation](), cellDescriptor:{ $0.cellDescriptor })

  override func viewDidLoad() {
    super.viewDidLoad()
    
    motivationsCollectionView.dataSource = motivationsDataSourse
    motivationsCollectionView.delegate = self
  
    let cellWidth = UIScreen.main.bounds.size.width
    let cellHeight = UIScreen.main.bounds.size.height - footerView.frame.height
    let layout = motivationsCollectionView.collectionViewLayout as! MotivationsLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
        
    setupDataForCollectionView()
  }

  func setupDataForCollectionView(){
    
    let firstItem = motivations[0]
    guard let lastItem = motivations.last else { return }
    
    fakeMotivations = motivations
    
    fakeMotivations.insert(lastItem, at: 0)
    fakeMotivations.append(firstItem)
    
    motivationsDataSourse.items = fakeMotivations
    motivationsCollectionView.dataSource = motivationsDataSourse
    motivationsCollectionView.reloadData()
  }
  
  @IBAction func unwindFromEdit(_ sender: UIStoryboardSegue){
    print("Back from Edit.Set changes here!")
  }

}

// MARK: - UICollectionViewDelegate

extension MotivationsViewController : UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    let motivation = fakeMotivations[indexPath.row]
    
    collectionView.backgroundColor = UIColor(hex: motivation.backgroundColor)
    footerView.backgroundColor = UIColor(hex: motivation.backgroundColor)
  
    fontName.text = motivation.fontType
    fontName.font = UIFont(name: motivation.fontType, size: 16.0)
    fontName.text = motivation.fontText
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

// MARK: - UIScrollViewDelegate

extension MotivationsViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
    
    // Calculate where the collection view should be at the right-hand end item
    let  contentOffsetWhenFullyScrolledRight = self.motivationsCollectionView.frame.size.width * CGFloat((fakeMotivations.count - 1))
    
      if scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight {
        
        // user is scrolling to the right from the last item to the 'fake' item 1.
        // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
        
        let newIndexPath = IndexPath(item: 1, section: 0)
        motivationsCollectionView.scrollToItem(at: newIndexPath, at:.left, animated: false)
        
      } else if scrollView.contentOffset.x == 0  {
        
        // user is scrolling to the left from the first item to the fake 'item N'.
        // reposition offset to show the 'real' item N at the right end end of the collection view
        
        let newIndexPath = IndexPath(item: (fakeMotivations.count  - 2), section: 0)
        motivationsCollectionView.scrollToItem(at: newIndexPath, at:.left, animated: false)
      }
  }
}


