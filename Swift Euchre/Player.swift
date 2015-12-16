//
//  Players.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

protocol Player: HandPossessor {
	var hand: Hand { get set }
	var name: String { get }
	var pos: String { get }
	var team: Int { get set }
	var loc: Int { get }
	
	init(playerName: String, team: Int, loc: Int)
}

extension Player {
	func loc2pos() -> String {
		return ""
	}
}