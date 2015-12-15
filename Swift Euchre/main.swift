//
//  main.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/1/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

print("Welcome to Swift Euchre!")


var players = [Hand]()
for _ in 1...4 {
	players.append(Hand.init())
}
var deck = makeDoubleEuchreDeck()
deck.deal(players)
for hand in players {
	hand.selectionDisplay()
}