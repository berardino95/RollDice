//
//  Dice.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

struct Dice : Codable {
    var numberOfDice : DiceNumber = DiceNumber.two
    var diceFaces : DiceFaces = DiceFaces.six
    var results : [Int] = []
    
    static let example = Dice(numberOfDice: .four, diceFaces: .six, results: [10, 20, 30, 50, 100])
    
}
