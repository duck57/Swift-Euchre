//
//  Cards.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/4/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

enum Rank: Int {
	case LoAce = 0
	case Deuce, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
	case Jack, Queen, King, HiAce, LeftBower, RightBower
	
	func dispName() ->String {
		switch self {
		case .LoAce:
			return "Ace"
		case .Deuce:
			return "Deuce"
		case Two:
			return "Two"
		case Three:
			return "Three"
		case Four:
			return "Four"
		case Five:
			return "Five"
		case Six:
			return "Six"
		case .Seven:
			return "Seven"
		case .Eight:
			return "Eight"
		case .Nine:
			return "Nine"
		case .Ten:
			return "Ten"
		case .Jack:
			return "Jack"
		case .Queen:
			return "Queen"
		case .King:
			return "King"
		case .HiAce:
			return "Ace"
		case .LeftBower:
			return "Left Bower"
		case .RightBower:
			return "Right Bower"
		}
	}
	
	func shortName(trumpAware: Bool?=nil) ->Character {
		if trumpAware == true && (self == .LeftBower || self  == .RightBower) {
			return "J"
		}
		switch self {
		case .Deuce:
			return "2"
		case .LoAce:
			return "A"
		case .Jack:
			return "J"
		case .Queen:
			return "Q"
		case .King:
			return "K"
		case .HiAce:
			return "A"
		case .LeftBower:
			return "◀"
		case .RightBower:
			return "▶"
		default:
			return Character(String(self.rawValue))
		}
	}
	
	func isValue(value: Rank) ->Bool {
		return self == value
	}
	func isNotValue(value: Rank) ->Bool {
		return !isValue(value)
	}
	
	func isAce() ->Bool {
		return self.isValue(.LoAce) || self.isValue(.HiAce)
	}
	
	func is2() ->Bool {
		return self.isValue(.Deuce) || self.isValue(.Two)
	}
	
	func isBower() ->Bool {
		return self.isValue(.LeftBower) || self.isValue(.RightBower)
	}
}

enum Suit: Int {
	case Joker = 0
	case Clubs, Diamonds, Spades, Hearts
	case Trump
	
	func dispName() ->String {
		switch self {
		case .Joker:
			return "Joker"
		case .Clubs:
			return "Clubs"
		case Diamonds:
			return "Diamonds"
		case .Spades:
			return "Spades"
		case .Hearts:
			return "Hearts"
		case .Trump:
			return "Trump"
		}
	}
	
	func shortName() ->Character {
		switch self {
		case .Joker:
			return "🃏"
		case .Clubs:
			return "♣️"
		case Diamonds:
			return "♦️"
		case .Spades:
			return "♠️"
		case .Hearts:
			return "♥️"
		case .Trump:
			return "🌟"
		}
	}
	
	func isSuit(suit: Suit) ->Bool {
		return self == suit
	}
	
	func isTrump() ->Bool {
		return isSuit(.Trump)
	}
	func isJoker() ->Bool {
		return isSuit(.Joker)
	}
	
	func isRed() ->Bool {
		return isSuit(.Diamonds) || isSuit(.Hearts)
	}
	func isBlack() ->Bool {
		return isSuit(.Clubs) || isSuit(.Spades)
	}
	
	func isNotTrump() ->Bool {
		return !isTrump()
	}
	func isPlayable() ->Bool {
		return !isJoker()
	}
	
	func isNormalSuit() ->Bool {
		if !isTrump() && !isJoker() {
			return true
		} else {
			return false
		}
	}
	func isUnusualSuit() ->Bool {
		if isTrump() || isJoker() {
			return true
		} else {
			return false
		}
	}
}



class card {
	var rank: Rank
	var suit: Suit
	
	init(r: Rank, s: Suit) {
		rank = r
		suit = s
	}
	
	//
	// Naming
	//
	
	// Trump-aware printout
	func longName(trumpSuit: Suit?=nil) ->String {
		var out = self.rank.dispName()
		if isBower() {
		} else if (trumpSuit != nil && self.isTrump()) {
			out += " of " + trumpSuit!.dispName()
		} else {
			out += " of " + self.suit.dispName()
		}
		return out
	}
	func shortName(trumpSuit: Suit?=nil) ->String {
		var s: Character
		let r = self.rank.shortName(trumpSuit != nil)
		
		s = p
		return String(r) + String(s)
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
	func makeCardTrump() {
		changeSuit((Suit).Trump)
	}
	func makeCardTrump(trumpSuit: Suit) {
		// Pass in a suit to add a safeguard
		if self.isBlack() {
			//
		}
	}
	func revertFromTrump(trumpSuit: Suit) {
		// Safeguard to prevet this from overwriting all cards when looping through a hand
		if self.isTrump() {
			changeSuit(trumpSuit)
		}
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
}