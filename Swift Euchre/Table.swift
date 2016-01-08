//
//  Table.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Table {
	var Players: [Player] = []
	var score: [Int] = []
	var deck: Deck
	var trick: Trick?
	var kitty: Hand?
	var trumpSuit: Suit?
	let winningScore: Int
	let losingScore: Int
	let terminalScore: Int
	var dealerPos: Int = 0
	var leadPos: Int = 0
	var winningBid: [Int] = []
	var scoringMethod: Int = 5 // default to Hi-No
	
	init(gameType: deckType, winningScore wScore: Int, losingScore lScore: Int, terminalScore tScore: Int) {
		deck = gameType.makeDeck()
		winningScore = wScore
		losingScore = lScore
		terminalScore = tScore
		score = [0, 0] // replace this with something better (that can handle 3-player games) later
		trick = Trick.init()
	}
	
	func deal() {
		deck.deal(Players)
		for var player in Players {
			player.sort()
		}
	}
	
	func callTrump(lead: Player?=nil) {
		//replace the beginning with the player calling trump
		let trump = Int(arc4random_uniform(6))
		scoringMethod = trump
		trumpSuit = Suit(rawValue: trump)
		for var player in self.Players {
			player.hand.convertToTrump(trumpSuit!)
			player.sort()
		}
	}
	
	func playGame() {
		dealerPos = randomPlayer()
		while scoreInRange() {
			playHand(dealerPos)
			scoreHand()
			nextDealer()
		}
	}
	
	func scoreHand() {
		let biddingTeam = winningBid[1] % 2
		if Players[biddingTeam].tricks + Players[biddingTeam+2].tricks < winningBid[0] {
			score[biddingTeam] = score[biddingTeam] - winningBid[0]
		} else {
			score[biddingTeam] = score[biddingTeam] + winningBid[0] + 2
		}
	}
	
	func playHand(dealerPos: Int) {
		deal()
		biddingSequence(dealerPos)
		for _ in Players[leadPos].hand {
			playTrick()
		}
	}
	
	func playTrick() {
		for loc in 0..<Players.count {
			trick!.append(Players[(leadPos+loc)%Players.count].playCard())
		}
		let winPos = trick!.score(scoringMethod == 0)
		leadPos = (leadPos + winPos) % Players.count
		Players[leadPos].tricks += 1
		trick!.empty(deck)
	}
	
	func biddingSequence(dealerPos: Int) {
		leadPos = randomPlayer() // replace this later
		callTrump()
		winningBid = [Int(arc4random_uniform(12)), leadPos]
		if winningBid[0] < 6 {
			winningBid[0] = 6
		}
	}
	
	func nextDealer() {
		dealerPos = nextPlayer(currentPlayer: dealerPos)
	}
	
	func randomPlayer() -> Int {
		return Int(arc4random_uniform(UInt32(Players.count)))
	}
	
	func nextPlayer(currentPlayer cp: Int) -> Int {
		return (cp + 1) % Players.count
	}
	
	func scoreInRange() -> Bool {
		if score.maxElement() > winningScore {
			return false // end game if someone won
		}
		if score.minElement() < losingScore {
			return false // end game if someone lost
		}
		for teamScore in score {
			if teamScore > terminalScore {
				return true
			}
		}
		return false // end game if all teams have significant negative scores
	}
	
}

extension Array {
	func forEach(doThis: (element: Element) -> Void) {
		for e in self {
			doThis(element: e)
		}
	}
}

protocol TrickTakingCardGame {
	//implement protocol-based thinking later
}

protocol TrickTakingCardSetup {
	//see above
}