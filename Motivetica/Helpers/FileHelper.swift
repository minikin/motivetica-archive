//
//  FileHelper.swift
//  Motivetica
//
//  Created by Sasha Minikin on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Foundation


func readKeysFrom(_ plistWithName: String) -> [String : String] {
  
        var motiveticaServerKeys = ["":""]

        if let url = Bundle.main.url(forResource:plistWithName, withExtension: "plist") {
          do {
            let data = try Data(contentsOf:url)
            motiveticaServerKeys = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:String]
  
//            let serverMasterKey = motiveticaServerKeys["PARSE_SERVER_MASTER_KEY"].flatMap{ return (string: $0)}
//            let serverRESTKey = motiveticaServerKeys["PARSE_SERVER_REST_API_KEY"].flatMap{ return (string: $0)}
//            let appID = motiveticaServerKeys["PARSE_SERVER_APPLICATION_ID"].flatMap{ return (string: $0)}
            
          } catch {
            print("Check that your .plist file exist!", error)
          }
        }
  
    return motiveticaServerKeys
}
