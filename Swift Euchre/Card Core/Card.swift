//
//  Cards.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/4/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public struct Card: Comparable {
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
	init(rnk: Int, sut: Int) {
		self.init(rnk: Rank(rawValue: rnk)!, sut: Suit(rawValue: sut)!)
	}
	
	//
	// Card functions
	//
	mutating func changeRank(newRank: Rank) {
		rank = newRank
	}
	mutating func changeSuit(newSuit: Suit) {
		suit = newSuit
	}
	mutating func makeTrump(var trumpSuit: Suit?=nil) {
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
	mutating func revertFromTrump(trumpSuit: Suit) {
		// Safeguard to prevet this from overwriting all cards when looping through a hand
		if isTrump() {
			changeSuit(trumpSuit)
		}
	}
	
	func isSameCard(compCard: Card) -> Bool {
		return compCard.isSuit(suit) && compCard.isValue(rank)
	}
	
	func beats(compCard: Card, compFunction: (Card, Card) -> Bool) -> Bool {
		return compFunction(compCard, self)
	}
}

extension Card: CustomStringConvertible {
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
		return longName()
	}
}

	//
	// Pass-through methods to the enums
	//
	
	// Rank
extension Card {
	func isAce() -> Bool {
		return rank.isAce()
	}
	func is2() -> Bool {
		return rank.is2()
	}
	func isBower() -> Bool{
		return rank.isBower()
	}
	func isValue(cmpVal: Rank)-> Bool {
		return rank.isValue(cmpVal)
	}
	func isNotVal(cmpVal: Rank) -> Bool {
		return rank.isNotValue(cmpVal)
	}
}
extension Card {
	// Suit
	func isRed() -> Bool {
		return self.suit.isRed()
	}
	func isBlack() -> Bool {
		return suit.isBlack()
	}
	func isSuit(chkSut: Suit) -> Bool {
		return suit.isSuit(chkSut)
	}
	func isTrump() -> Bool {
		return suit.isTrump()
	}
	func isNotTrump() -> Bool {
		return suit.isNotTrump()
	}
	func isJoker() -> Bool {
		return suit.isJoker()
	}
	func isNotJoker() -> Bool { // If you have strong feelings one way or the other about this, let me know which name you prefer: isNotJoker or isPlayable
		return suit.isPlayable()
	}
	func isNormalSuit() -> Bool {
		return suit.isNormalSuit()
	}
	func isSpecialSuit() -> Bool { // Again, which name is better: isSpecialSuit or isUnusualSuit?
		return suit.isUnusualSuit()
	}
	func followsSuit(chkSuit: Suit) -> Bool{ // This should be more useful for scoring
		return isSuit(chkSuit) || self.isTrump() // don't use this when evaluating player hands
	}
	
	func isValidCard() -> Bool {
		return isNotJoker() && rank.isValid()
	}
}

// For Comparable
public func <(L🎴: Card, R🎴: Card) -> Bool {
	// Swap which of the below lines is commented to change the default sorting method
	return SuitSorted(L🎴, R🎴)
	//return RankSorted(L🎴, R🎴)
	//return DisplaySorted(L🎴, R🎴)
}
public func ==(L🎴: Card, R🎴: Card) -> Bool {
	return L🎴.isSameCard(R🎴)
}


// Better implementations of sorting
public func SuitSorted(L🎴: Card, _ R🎴: Card) -> Bool {
	// Compare suit first.
	if L🎴.suit != R🎴.suit {
		return L🎴.suit < R🎴.suit
	}
	// Same suit, need to sort by rank.
	return L🎴.rank < R🎴.rank
}
// Same as above but with Rank and Suit swapped
public func RankSorted(L🎴: Card, _ R🎴: Card) -> Bool {
	if L🎴.rank != R🎴.rank {
		return L🎴.rank < R🎴.rank
	}
	return L🎴.suit < R🎴.suit
}

// Sorts trump cards as if they were members of the suit that was declared trump
public func DisplaySorted(L🎴: Card, _ R🎴: Card) -> Bool {
	let lsuit = L🎴.rank == (Rank).LeftBower ? L🎴.displaySuit.oppositeSuit() : L🎴.displaySuit
	let rsuit = R🎴.rank == (Rank).LeftBower ? R🎴.displaySuit.oppositeSuit() : R🎴.displaySuit
	if lsuit != rsuit {
		return lsuit < rsuit
	}
	return L🎴.rank < R🎴.rank
}