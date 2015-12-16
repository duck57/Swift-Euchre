//
//  rank.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/7/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation


public enum Rank: Int {
	case LoAce = 0
	case Deuce, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
	case Jack, Queen, King, HiAce, LeftBower, RightBower
	case invalid = -1
	case blank = -2
	
	func dispName() -> String {
		switch self {
		case LoAce:
			return "Ace"
		case Deuce:
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
		case Seven:
			return "Seven"
		case Eight:
			return "Eight"
		case Nine:
			return "Nine"
		case Ten:
			return "Ten"
		case Jack:
			return "Jack"
		case Queen:
			return "Queen"
		case King:
			return "King"
		case HiAce:
			return "Ace"
		case LeftBower:
			return "Left Bower"
		case RightBower:
			return "Right Bower"
		default:
			return ""
		}
	}
	
	// Leaving in trumpAware in case it's useful to have that hard-coded here.
	func shortName(trumpAware: Bool?=nil) -> Character {
		if trumpAware == true && (self == LeftBower || self  == RightBower) {
			return "J"
		}
		switch self {
		case Deuce:
			return "2"
		case LoAce:
			return "A"
		case Ten:
			return "⒑" // need this or some other non-ASCII representation of 10 to prevent runtime errors
		case Jack:
			return "J"
		case Queen:
			return "Q"
		case King:
			return "K"
		case HiAce:
			return "A"
		case LeftBower:
			return "◀"
		case RightBower:
			return "▶"
		default:
			return Character(String(self.rawValue))
		}
	}
	
	func isValue(value: Rank) -> Bool {
		return self == value
	}
	func isNotValue(value: Rank) -> Bool {
		return !isValue(value)
	}
	
	func isAce() -> Bool {
		return isValue(.LoAce) || isValue(.HiAce)
	}
	
	func is2() -> Bool {
		return isValue(.Deuce) || isValue(.Two)
	}
	
	func isBower() -> Bool {
		return isValue(.LeftBower) || isValue(.RightBower)
	}
	
	func isValid() -> Bool {
		return !invalidRank()
	}
	func invalidRank() -> Bool {
		return isValue(.invalid) || isValue(.blank)
	}
}

public func <(left: Rank, right: Rank) -> Bool {
	return left.rawValue < right.rawValue
}