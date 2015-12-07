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
			deck.append(Card.init(r: rank, s: suit))
		}
	}
}

func makeDoubleEuchreDeck() {
	makeEuchreDeck()
	makeEuchreDeck()
}

extension CollectionType {
	/// Return a copy of `self` with its elements shuffled
	func shuffle() -> [Generator.Element] {
		var list = Array(self)
		list.shuffleInPlace()
		return list
	}
}

extension MutableCollectionType where Index == Int {
	/// Shuffle the elements of `self` in-place.
	mutating func shuffleInPlace() {
		// empty and single-element collections don't shuffle
		if count < 2 { return }
		
		for i in 0..<count - 1 {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
			guard i != j else { continue }
			swap(&self[i], &self[j])
		}
	}
}