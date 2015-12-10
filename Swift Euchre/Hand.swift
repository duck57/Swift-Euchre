//
//  Hand.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

var hand = [Card]()

func humanSort(trumpSuit: Suit) {
	for card in hand {
		card.revertFromTrump(trumpSuit)
	}
	hand.sortInPlace()
}