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
    var results : [Result] = []
    var resultForEachDice : String = ""
    var hapticFeedbackIsEnable = true
}
