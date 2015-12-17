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
	var trick: Trick?
	var kitty: Hand?
	var trumpSuit: Suit?
	
	init(gameType: deckType) {
		deck = gameType.makeDeck()
	}
	
	func deal() {
		deck.deal(Players)
	}
	
}

extension Array {
	func forEach(doThis: (element: Element) -> Void) {
		for e in self {
			doThis(element: e)
		}
	}
}