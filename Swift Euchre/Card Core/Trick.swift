//
//  Trick.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

struct Trick: CardCollection {
	var collective = [Card]()
	init() {  }
}

extension Trick: CustomStringConvertible {
	var description: String {
		var out = ""
		for 🎴 in self {
			out += 🎴.shortName() + " "
		}
		return out
	}
}