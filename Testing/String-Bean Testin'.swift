//
//  String-Bean Testin'.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/7/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

// fun fact: either XCode or Swift completely bugs out whenever you use a suit as part of a variable name.
// It doesn't even have to be an emoji-style playing card suit character, any one will do
// ♤♠︎♠️♠ all broken for sure
// ♥️❤️ one of these also for sure broken (I don't know which I tested)
// ♡♥❤❤︎♥︎♧♣︎♣️♣♦︎♦♦️♢ probably also broken as well
//
// I'm leaving this comment in for a few commits

// As it turns out, it's because the emoji-style suit characters are actually two characters, one of which is non-printable.
// Not a bug, just bad UI: should give a warning that the character entered is actually a complex glyph instead of a single unicode code point.



for i in 0x1F240...0x1F340 {
	let char = UnicodeScalar(i)
	print(char)
}



let testString = "\u{e9}\u{65}\u{301}"

for scalar in testString.unicodeScalars {
	print("0x\(String(format:"%2X",scalar.value))", terminator: " ")
}

print("\n\u{2660}\n")
print("\u{FE0F}\n")