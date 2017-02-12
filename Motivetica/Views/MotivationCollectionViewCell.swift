//
//  MotivationCollectionViewCell.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class MotivationCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var fontName: UILabel!
  @IBOutlet weak var fornWeight: UILabel!
  @IBOutlet weak var textColor: UIImageView!
  @IBOutlet weak var textAllignment: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}


