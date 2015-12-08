//
//  main.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/1/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

print("Welcome to Swift Euchre!")


makeDoubleEuchreDeck()
deck.sortInPlace({RankSorted($0,$1)})

for card in deck {
	print(card)
}