//
//  MotivationsDataSource.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//
//  Abstract:
//  MotivationsDataStore class responsible for responding to data source (UICollectionViewDataSource)


import UIKit

class MotivationsDataSource: NSObject, UICollectionViewDataSource {
  
  var motivations : [Motivation] = []
  
  // MARK: - Table view data source
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return motivations.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "motivationCell", for: indexPath) as! MotivationCollectionViewCell
    
    // Configure the cell...
    
    let motivation = motivations[indexPath.row]
    
    cell.textView.text = motivation.motivationText
    cell.fontName.text = motivation.fontType
    cell.fornWeight.text = motivation.fontWeight
    
    return cell
  }
}
