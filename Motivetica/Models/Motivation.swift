//
//  Motivation.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/8/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation
import UIKit

struct Motivation {
  let id: String
  let name: String
  let fontName: String
  let fontSize: String
  let fontColor: String
  let backgroundColor: String
}

extension Motivation {
  public init?(json: JSONDictionary){
    guard let id = json["objectId"] as? String,
      let name = json["motivationText"] as? String,
      let fontName = json["fontType"] as? String,
      let fontSize = json["fontSize"] as? String,
      let fontColor = json["fontColor"] as? String,
      let backgroundColor = json["backgroundColor"] as? String else {
        return nil
    }
    
    self.id = id
    self.name = name
    self.fontName = fontName
    self.fontSize = fontSize
    self.fontColor = fontColor
    self.backgroundColor = backgroundColor
  }
}
