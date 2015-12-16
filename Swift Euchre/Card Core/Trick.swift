//
//  Trick.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Trick: CardCollection {
	var collective = [Card]()
	required init() {  }
	
	// Return the position of the winning card
	func score(LoNo: (Card, Card) -> Bool, scoringfunction: (Card, Card, (Card, Card) -> Bool?) -> Bool?=beats) -> Int {
		var winPos = 0
		for rLoc in 1..<self.count-1 {
			if beats(self[winPos], self[rLoc], SortFunction: LoNo) {
				winPos = rLoc
			}
		}
		return winPos
	}
	
	deinit {
		empty(nil)
	}
	
	func returnToDeck(loc pos: Int?=nil, var deck: Deck) -> Card? {
		if let pos = pos {
			guard pos < self.count else {
				print("Index \(pos) is greater than trick size (\(self.count))")
				return nil
			}
			let 🎴 = collective.removeAtIndex(pos)
			deck.append(🎴)
			return 🎴
		} else {
			return returnToDeck(loc: 0, deck: deck)
		}
	}
	
	func empty(deck: Deck?) {
		for _ in self {
			returnToDeck(deck: deck!)
		}
	}
	
}

extension Trick: CustomStringConvertible {
	var description: String {
		var out = ""
		for 🎴 in self {
			out += 🎴.shortName() + " "
		}
		return out
	}
}

// Returns whether the R card beats the L card (must follow suit or be trump)
func beats(L🎴: Card, _ R🎴: Card, SortFunction: (Card, Card) -> Bool?=SuitSorted) -> Bool {
	if R🎴.suit != L🎴.suit && R🎴.suit != (Suit).Trump {
		return false
	}
	return SortFunction(L🎴, R🎴)!
}

func LoNo(L🎴: Card, _ R🎴: Card) -> Bool {
	return R🎴.suit == L🎴.suit && R🎴 < L🎴
}