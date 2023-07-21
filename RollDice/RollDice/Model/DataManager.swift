//
//  DataManager.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

class DataManager : ObservableObject{
    
    static let savePath = FileManager.documentDirectory.appendingPathComponent("SavedData")
    
    static func loadData() -> Dice {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode(Dice.self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return Dice()
    }
    
    static func save(_ data: Dice){
        do{
            let data = try JSONEncoder().encode(data)
            try data.write(to: DataManager.savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

