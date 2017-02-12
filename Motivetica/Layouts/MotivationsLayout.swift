//
//  MotivationsLayout.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 2/5/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class MotivationsLayout: UICollectionViewFlowLayout {
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    if let cv = self.collectionView {
      
      let cvBounds = cv.bounds
      let halfWidth = cvBounds.size.width * 0.5;
      
      let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
      
      if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
        
        var candidateAttributes : UICollectionViewLayoutAttributes?
        for attributes in attributesForVisibleCells {
          
          // == Skip comparison with non-cell items (headers and footers) == //
          if attributes.representedElementCategory != UICollectionElementCategory.cell {
            continue
          }
          
          if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
            continue
          }
          
          // == First time in the loop == //
          guard let candAttrs = candidateAttributes else {
            candidateAttributes = attributes
            continue
          }
          
          let a = attributes.center.x - proposedContentOffsetCenterX
          let b = candAttrs.center.x - proposedContentOffsetCenterX
          
          if fabsf(Float(a)) < fabsf(Float(b)) {
            candidateAttributes = attributes;
          }
        }
        
        // Beautification step
        if(proposedContentOffset.x == -(cv.contentInset.left)) {
          return proposedContentOffset
        }
        
        return CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
      }
    }
    
    // fallback
    return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
  }

  
  
  
}
