//
//  DiceNumberEnum.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

enum DiceNumber : Int, CaseIterable, Identifiable, Codable {
    case one = 1, two = 2, three = 3, four = 4
    var id: Self { self }
}
