//
//  main.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/1/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

print("Welcome to Swift Euchre!")


var Game = Table.init(gameType: (deckType).DoubleEuchre)

Game.Players.append(ComputerPlayer.init(playerName: "Mike", team: 0, loc: 0))
Game.Players.append(ComputerPlayer.init(playerName: "Bob", team: 1, loc: 1))
Game.Players.append(HumanPlayer.init(playerName: "Chris", team: 0, loc: 2))
Game.Players.append(ComputerPlayer.init(playerName: "Charlie", team: 1, loc: 3))


Game.deal()
let i = Int(arc4random_uniform(6))
for var player in Game.Players {
	player.hand.convertToTrump(Suit(rawValue: i)!)
	player.sort()
	player.hand.selectionDisplay()
}