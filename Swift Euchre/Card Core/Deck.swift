//
//  Deck.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Deck: CardCollection {
	var collective = [Card]()
	convenience required init() {
		self.init()
	}
	init(_ lowRank: Int, _ highRank: Int, number: Int?=1) {
		for _ in 1...number! {
			for suit in 1...4 {
				for rank in lowRank...highRank {
					collective.append(Card(rnk: rank, sut: suit))
				}
			}
		}
	}
	convenience init(lowRank: Rank, highRank: Rank, number: Int?=1) {
		self.init(lowRank.rawValue, highRank.rawValue, number: number)
	}
}

func makeEuchreDeck(number: Int?=1) -> Deck {
	return Deck.init(lowRank: (Rank).Nine, highRank: (Rank).HiAce, number: number!)
}

func makeDoubleEuchreDeck() -> Deck {
	return makeEuchreDeck(2)
}