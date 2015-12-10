//
//  Deck.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public var deck = [Card]()

func makeEuchreDeck() {
	for suit in 1...4 {
		for rank in 9...14 {
			deck.append(Card.init(rnk: rank, sut: suit))
		}
	}
}

func makeDoubleEuchreDeck() {
	makeEuchreDeck()
	makeEuchreDeck()
}