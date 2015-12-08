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

extension CollectionType {
	/// Return a copy of `self` with its elements shuffled
	func shuffle() -> [Generator.Element] {
		var list = Array(self)
		list.shuffleInPlace()
		return list
	}
}

extension CollectionType where Generator.Element == Card {
	func sortedBySuit() -> [Generator.Element] {
		var list = Array(self)
		list.suitSort()
		return list
	}
	func sortedByRank() -> [Generator.Element] {
		var list = Array(self)
		list.rankSort()
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

extension MutableCollectionType where Generator.Element == Card {
	mutating func suitSort() {
		self.sortInPlace({SuitSorted($0,$1)})
	}
	mutating func rankSort() {
		self.sortInPlace({RankSorted($0,$1)})
	}
}