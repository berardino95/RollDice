//
//  Result.swift
//  RollDice
//
//  Created by Berardino Chiarello on 23/07/23.
//

import Foundation

struct Result: Codable, Identifiable {
    
    var id = UUID()
    var total : Int
    var resultForEachDice : String
}
