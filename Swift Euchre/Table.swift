//
//  Table.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Table {
	var Players: [Player] = []
	var score: [Int] = []
	var deck: Deck
	var trick: Trick? = nil
	var kitty: Hand? = nil
	var trumpSuit: Suit? = nil
	
	init(gameType: deckType) {
		deck = gameType.makeDeck()
	}
	
}

extension Array {
	func forEach(doThis: (element: Element) -> Void) {
		for e in self {
			doThis(element: e)
		}
	}
}