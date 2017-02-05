//
//  EditViewController.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 2/5/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
  
  @IBOutlet weak var leftAlign: UIButton!
  @IBOutlet weak var centerAlig: UIButton!
  @IBOutlet weak var whiteColor: UIButton!
  @IBOutlet weak var blackColor: UIButton!

  @IBOutlet weak var fontPicker: UIPickerView!
  
  
  let pickerData = ["Font 1", "Font 2", "Font 3", "Font 4"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    fontPicker.delegate = self
    fontPicker.dataSource = self
  }


  
  @IBAction func saveToCamera(_ sender: UIButton) {
    
  }
  
}



extension EditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    // Do something with the row
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let pickerLabel = UILabel()
    let titleData = pickerData[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 32.0)!,NSForegroundColorAttributeName:UIColor.black])
    pickerLabel.attributedText = myTitle
    return pickerLabel
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 60.0
  }

//  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//    var label: UILabel
//    
//    if let view = view as? UILabel {
//      label = view
//    } else {
//      label = UILabel()
//    }
//    
//    label.textColor = .black
//    label.textAlignment = .center
//    label.font = UIFont(name: "SanFranciscoText-Light", size: 18)
//    
//    // where data is an Array of String
//    label.text = pickerData[row]
//    
//    return label
//  }
}
  

