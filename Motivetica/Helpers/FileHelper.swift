//
//  FileHelper.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation

func readKeysFrom(_ plistWithName: String) -> [String : String] {
  
        var motiveticaServerKeys = ["":""]

        if let url = Bundle.main.url(forResource:plistWithName, withExtension: "plist") {
          do {
            let data = try Data(contentsOf:url)
            motiveticaServerKeys = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:String]
          } catch {
            print("Check that your .plist file exist!", error)
          }
        }
  
    return motiveticaServerKeys
}
