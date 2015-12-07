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
	
	init(r: Rank, s: Suit) {
		rank = r
		suit = s
	}
	convenience init(r: Int, s: Int) {
		self.init(r: Rank(rawValue: r)!, s: Suit(rawValue: s)!)
	}
	
	//
	// Naming
	//
	
	// Trump-aware printout
	func longName(var trumpSuit: Suit?=nil) ->String {
		var out = self.rank.dispName()
		if isBower() {} else if self.isTrump() {
			trumpSuit = trumpSuit ?? (Suit).Trump
			out += " of " + trumpSuit!.dispName()
		} else {
			out += " of " + self.suit.dispName()
		}
		return out
	}
	func shortName(var trumpSuit: Suit?=nil) ->String {
		var S: Character
		let r = self.rank.shortName(trumpSuit != nil)
		
		if self.rank.isValue((Rank).LeftBower) {
			S = self.suit.oppositeSuit().shortName()
		} else if self.isTrump() {
			trumpSuit = trumpSuit ?? (Suit).Trump
			S = trumpSuit!.shortName()
		} else {
			S = self.suit.shortName()
		}
		
		return String(r) + String(S)
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
	
	func isSameCard(compCard: Card) ->Bool {
		return compCard.isSuit(self.suit) && compCard.isValue(self.rank)
	}
	
	//
	// Pass-through methods to the enums
	//
	
	// Rank
	func isAce() ->Bool {
		return self.rank.isAce()
	}
	func is2() ->Bool {
		return self.rank.is2()
	}
	func isBower() ->Bool{
		return self.rank.isBower()
	}
	func isValue(cmpVal: Rank)->Bool {
		return self.rank.isValue(cmpVal)
	}
	func isNotVal(cmpVal: Rank) ->Bool {
		return self.rank.isNotValue(cmpVal)
	}
	
	// Suit
	func isRed() ->Bool {
		return self.suit.isRed()
	}
	func isBlack() ->Bool {
		return self.suit.isBlack()
	}
	func isSuit(chkSut: Suit) ->Bool {
		return self.suit.isSuit(chkSut)
	}
	func isTrump() ->Bool {
		return self.suit.isTrump()
	}
	func isNotTrump() ->Bool {
		return self.suit.isNotTrump()
	}
	func isJoker() ->Bool {
		return self.suit.isJoker()
	}
	func isNotJoker() ->Bool { // If you have strong feelings one way or the other about this, let me know which name you prefer
		return self.suit.isPlayable()
	}
	func isNormalSuit() ->Bool {
		return self.suit.isNormalSuit()
	}
	func isSpecialSuit() ->Bool { // Again, which name is better?
		return self.suit.isUnusualSuit()
	}
	func followsSuit(chkSuit: Suit) ->Bool{ // This should be more useful for scoring
		return self.isSuit(chkSuit) || self.isTrump()
	}
}

// For Comparable
public func <(left: Card, right: Card) -> Bool {
	if left.suit < right.suit {
		return true
	}
	return left.rank < right.rank
}
public func ==(left: Card, right: Card) -> Bool {
	return left.isSameCard(right)
}