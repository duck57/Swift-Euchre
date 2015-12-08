//
//  suit.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/7/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public enum Suit: Int {
	case Joker = 0
	case Clubs, Diamonds, Spades, Hearts
	case Trump
	
	func dispName() -> String {
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
	
	func shortName() -> Character {
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
	
	func oppositeSuit() -> Suit {
		switch self {
		case .Clubs:
			return .Spades
		case Diamonds:
			return .Hearts
		case .Spades:
			return .Clubs
		case .Hearts:
			return .Diamonds
		default:
			return self
		}
	}
	
	// These functions also have pass-throughs in the Card class
	
	func isSuit(suit: Suit) -> Bool {
		return self == suit
	}
	
	func isTrump() -> Bool {
		return isSuit(.Trump)
	}
	func isJoker() -> Bool {
		return isSuit(.Joker)
	}
	
	func isRed() -> Bool {
		return isSuit(.Diamonds) || isSuit(.Hearts)
	}
	func isBlack() -> Bool {
		return isSuit(.Clubs) || isSuit(.Spades)
	}
	
	func isNotTrump() -> Bool {
		return !isTrump()
	}
	func isPlayable() -> Bool {
		return !isJoker()
	}
	
	func isNormalSuit() -> Bool {
		if !isTrump() && !isJoker() {
			return true
		} else {
			return false
		}
	}
	func isUnusualSuit() -> Bool {
		if isTrump() || isJoker() {
			return true
		} else {
			return false
		}
	}
}

public func <(left: Suit, right: Suit) -> Bool {
	return left.rawValue < right.rawValue
}