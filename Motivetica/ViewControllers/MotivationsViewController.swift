//
//  MotivationsViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 1/29/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class MotivationsViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  let motivationsDataSourse = MotivationsDataSource()
  
  let webservice = Webservice()
  
  var allMotivations: Resource<[Motivation]> = try! Resource(
    url: URL(string: "https://motivetica.com/parse/classes/Motivation")!,
    parseKey: "results",
    parseElement: Motivation.init)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.dataSource = motivationsDataSourse
      
      webservice.load(allMotivations) { result in
        print(result)
        self.motivationsDataSourse.motivations = result.value!
        self.collectionView.reloadData()
      }
    }



}
