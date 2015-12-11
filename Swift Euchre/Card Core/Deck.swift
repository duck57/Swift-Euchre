//
//  Deck.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public class deck: CardCollection {
	init(_ lowRank: Int, _ highRank: Int, number: Int?=1) {
		for _ in 1...number! {
			for suit in 1...4 {
				for rank in lowRank...highRank {
					collective.append(Card.init(rnk: rank, sut: suit))
				}
			}
		}
	}
	convenience init(lowRank: Rank, highRank: Suit, number: Int?=1) {
		self.init(lowRank.rawValue, highRank.rawValue, number: number)
	}
	
}

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