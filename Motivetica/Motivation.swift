//
//  Motivation.swift
//  Motivetica
//
//  Created by Sasha Prokhorenko on 18/10/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import Foundation
import UIKit

struct Motivation {
	
	let identifier: String
	let name: String
	let fontName: String
	let fontSize: Int
	let fontColor: UIColor
	let backgroundColor: UIColor
	
	init(identifier: String, name: String, fontName: String, fontSize: Int, fontColor:UIColor, backgroundColor: UIColor) {
		self.identifier = identifier
		self.name	=	name
		self.fontName	=	fontName
		self.fontSize	=	fontSize
		self.fontColor	=	fontColor
		self.backgroundColor	=	backgroundColor
	}
	
	
}
