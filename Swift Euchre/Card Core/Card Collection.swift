//
//  CardCollection.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/12/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

protocol CardCollection : RangeReplaceableCollectionType, CustomStringConvertible {
	var collective : [Card] { get set }
}

extension CardCollection  {
	var startIndex : Int { return collective.startIndex }
	var endIndex : Int { return collective.endIndex }
	
	subscript(position : Int) -> Card {
		get {
			return collective[position]
			
		}
		set(newElement) {
			collective[position] = newElement
		}
	}
	
	mutating func replaceRange<C : CollectionType where C.Generator.Element == Card>(subRange: Range<Int>, with newElements: C) {
		collective.replaceRange(subRange, with: newElements)
	}
	
	mutating func shuffleInPlace() {
		collective.shuffleInPlace()
	}
	
	mutating func sortInPlace(sortFun: (Card, Card) -> Bool?=DisplaySorted) {
		collective.sortInPlace({sortFun($0,$1)!})
	}
	
	mutating func sortBySuit() {
		sortInPlace(SuitSorted)
	}
	mutating func sortByRank() {
		sortInPlace(RankSorted)
	}
	mutating func sortForDisplay() {
		sortInPlace(DisplaySorted)
	}
	
	// for some reason, it complains about card being a let variable if I use
	// for card in collective { card.makeTrump(trumpSuit) }
	mutating func convertToTrump(trumpSuit: Suit) {
		for i in 0..<collective.count {
			collective[i].makeTrump(trumpSuit)
		}
	}
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