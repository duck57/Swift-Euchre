//
//  Computer Player.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class ComputerPlayer: Player {
	var hand: Hand
	var name: String
	var pos: String
	var team: Int
	var loc: Int
	var tricks: Int = 0
	
	required init(playerName: String, team playerTeam: Int, loc location: Int) {
		name = playerName
		team = playerTeam
		loc = location
		hand = Hand.init()
		pos = ""
	}
	
	func playCard() -> Card {
		return hand.removeAtIndex(0)
	}
	
	func sort() {
		hand.sortBySuit()
	}
}