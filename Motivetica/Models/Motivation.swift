//
//  Motivation.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/8/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation
import UIKit
import Hue

struct Motivation {
  let id: String
  let published: Bool
  let motivationText: String
  let fontType: String
  let fontWeight: String
  let fontSize: String
  let fontColor: String
  let textAlignment: String
  let backgroundColor: String
}

extension Motivation {
   init?(json: JSONDictionary){
    guard let id = json["objectId"] as? String,
      let published = json["published"] as? Bool,
      let motivationText = json["motivationText"] as? String,
      let fontType = json["fontType"] as? String,
      let fontWeight = json["fontWeight"] as? String,
      let fontSize = json["fontSize"] as? String,
      let fontColor = json["fontColor"] as? String,
      let textAlignment = json["textAlignment"] as? String,
      let backgroundColor = json["backgroundColor"] as? String else {
        print("Could not create motivation from json: \(json)")
        return nil
    }
    
    self.id = id
    self.published = published
    self.motivationText = motivationText
    self.fontType = fontType
    self.fontWeight = fontWeight
    self.fontSize = fontSize
    self.fontColor = fontColor
    self.textAlignment = textAlignment
    self.backgroundColor = backgroundColor
  }
}

extension Motivation {
  static let all = try! Resource<[Motivation]>(
        url: URL(string: "https://motivetica.com/parse/classes/Motivation")!,
        parseKey: "results",
        parseElement: Motivation.init)
}

extension Motivation {
  func configureCell(_ cell: MotivationCollectionViewCell) {
    
    cell.backgroundColor = UIColor(hex: backgroundColor)
    cell.textView.backgroundColor = UIColor(hex: backgroundColor)
    cell.textView.textColor = UIColor(hex: fontColor)
    cell.textView.text = motivationText
    
    
    //print("CELL DATA:", UIFont(name: fontType, size: CGFloat(NumberFormatter().number(from: fontSize)!)))
    
    cell.textView.font = UIFont(name: fontType, size: CGFloat(NumberFormatter().number(from: fontSize)!))
    
    cell.fontName.text = fontType
    cell.fontName.font =  UIFont(name: fontType, size: 16.0)
    cell.fontName.textColor = UIColor(hex: fontColor)
    cell.fornWeight.text = fontWeight
    cell.fornWeight.font = UIFont(name: fontType, size: 12.0)
    cell.fornWeight.textColor = UIColor(hex: fontColor)
    
    
    
    
  }
}

extension Motivation {
  var cellDescriptor: CellDescriptor {
      return CellDescriptor(reuseIdentifier: "motivationCell", configure: self.configureCell)
  }
}


