//
//  Cards.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/4/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public class Card: Comparable, CustomStringConvertible {
	var rank: Rank
	var suit: Suit
	let displayRank: Rank
	let displaySuit: Suit
	
	init(rnk: Rank, sut: Suit) {
		rank = rnk
		suit = sut
		//the display versions require fewer special functions and considerations
		displayRank = rank
		displaySuit = suit
	}
	convenience init(rnk: Int, sut: Int) {
		self.init(rnk: Rank(rawValue: rnk)!, sut: Suit(rawValue: sut)!)
	}
	
	//
	// Naming
	//
	
	// Long Name: better for debugging, since relies on the "actual" value of the card
	func longName(var trumpSuit: Suit?=nil) -> String {
		var out = self.rank.dispName()
		if isBower() {} else if self.isTrump() {
			trumpSuit = trumpSuit ?? (Suit).Trump
			out += " of " + trumpSuit!.dispName()
		} else {
			out += " of " + self.suit.dispName()
		}
		return out
	}
	// Human-readable form for 2-character display
	func shortName(trumpSuit: Suit?=nil) -> String {
		let S = self.displaySuit.shortName()
		let R = self.displayRank.shortName()
		return String(R) + String(S)
	}
	
	// Fulfill CustomStringConvertible
	public var description: String {
		return self.longName()
	}
	
	
	//
	// Card functions
	//
	func changeRank(newRank: Rank) {
		self.rank = newRank
	}
	func changeSuit(newSuit: Suit) {
		self.suit = newSuit
	}
	func makeTrump(var trumpSuit: Suit?=nil) {
		// Pass in a suit to add a safeguard
		// Don't pass in a suit for force the card to trump
		if trumpSuit == nil {
			changeSuit((Suit).Trump)
			return
		}
		
		trumpSuit = trumpSuit ?? (Suit).Trump
		if isSuit(trumpSuit!) {
			makeTrump()
			if isValue((Rank).Jack) {
				changeRank((Rank).RightBower)
			}
		}
		if isSuit(trumpSuit!.oppositeSuit()) && isValue((Rank).Jack) {
			makeTrump()
			changeRank((Rank).LeftBower)
		}
	}
	func revertFromTrump(trumpSuit: Suit) {
		// Safeguard to prevet this from overwriting all cards when looping through a hand
		if self.isTrump() {
			changeSuit(trumpSuit)
		}
	}
	
	func isSameCard(compCard: Card) -> Bool {
		return compCard.isSuit(self.suit) && compCard.isValue(self.rank)
	}
	
	func beats(compCard: Card, compFunction: (Card, Card) -> Bool) -> Bool {
		return compFunction(compCard, self)
	}
	
	//
	// Pass-through methods to the enums
	//
	
	// Rank
	func isAce() -> Bool {
		return self.rank.isAce()
	}
	func is2() -> Bool {
		return self.rank.is2()
	}
	func isBower() -> Bool{
		return self.rank.isBower()
	}
	func isValue(cmpVal: Rank)-> Bool {
		return self.rank.isValue(cmpVal)
	}
	func isNotVal(cmpVal: Rank) -> Bool {
		return self.rank.isNotValue(cmpVal)
	}
	
	// Suit
	func isRed() -> Bool {
		return self.suit.isRed()
	}
	func isBlack() -> Bool {
		return self.suit.isBlack()
	}
	func isSuit(chkSut: Suit) -> Bool {
		return self.suit.isSuit(chkSut)
	}
	func isTrump() -> Bool {
		return self.suit.isTrump()
	}
	func isNotTrump() -> Bool {
		return self.suit.isNotTrump()
	}
	func isJoker() -> Bool {
		return self.suit.isJoker()
	}
	func isNotJoker() -> Bool { // If you have strong feelings one way or the other about this, let me know which name you prefer: isNotJoker or isPlayable
		return self.suit.isPlayable()
	}
	func isNormalSuit() -> Bool {
		return self.suit.isNormalSuit()
	}
	func isSpecialSuit() -> Bool { // Again, which name is better: isSpecialSuit or isUnusualSuit?
		return self.suit.isUnusualSuit()
	}
	func followsSuit(chkSuit: Suit) -> Bool{ // This should be more useful for scoring
		return self.isSuit(chkSuit) || self.isTrump() // don't use this when evaluating player hands
	}
}

// For Comparable
public func <(leftCard: Card, rightCard: Card) -> Bool {
	// Swap which of the below lines is commented to change the default sorting method
	return SuitSorted(leftCard, rightCard)
	//return RankSorted(leftCard, rightCard)
}
public func ==(leftCard: Card, rightCard: Card) -> Bool {
	return leftCard.isSameCard(rightCard)
}


// Better implementations of sorting
public func SuitSorted(leftCard: Card, _ rightCard: Card) -> Bool {
	// Compare suit first.
	if leftCard.suit != rightCard.suit {
		return leftCard.suit < rightCard.suit
	}
	// Same suit, need to sort by rank.
	return leftCard.rank < rightCard.rank
}
// Same as above but with Rank and Suit swapped
public func RankSorted(leftCard: Card, _ rightCard: Card) -> Bool {
	if leftCard.rank != rightCard.rank {
		return leftCard.rank < rightCard.rank
	}
	return leftCard.suit < rightCard.suit
}

public class cardCollection {
	var collective = [Card]()
	
	func suitSort() {
		self.collective.sortInPlace({SuitSorted($0,$1)})
	}
	func rankSort() {
		self.collective.sortInPlace({RankSorted($0,$1)})
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

/*
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
}*/

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

/*
extension MutableCollectionType where Generator.Element == Card {
	mutating func suitSort() {
		self.sortInPlace({SuitSorted($0,$1)})
	}
	mutating func rankSort() {
		self.sortInPlace({RankSorted($0,$1)})
	}
}*/