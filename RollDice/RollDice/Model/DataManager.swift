//
//  DataManager.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation


class DataManager : ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case numberOfDice, diceFaces, results
    }
    
    @Published var numberOfDice : DiceNumber
    @Published var diceFaces : DiceFaces
    @Published var results = [Int]()
    
    let savePath = FileManager.documentDirectory.appendingPathComponent("SavedData")
    
//    init(){
//        do {
//            let data = try Data(contentsOf: savePath)
//            self.numberOfDice = try JSONDecoder().decode(DiceNumber.self, from: data)
//            self.diceFaces = try JSONDecoder().decode(DiceFaces.self, from: data)
//            self.results = try JSONDecoder().decode([Int].self, from: data)
//        } catch {
//            print("Error: \(error.localizedDescription)")
//            self.numberOfDice = DiceNumber.two
//            self.diceFaces = DiceFaces.six
//        }
//    }
    
    func loadData(){
        do {
            let data = try Data(contentsOf: savePath)
            numberOfDice = try JSONDecoder().decode(DiceNumber.self, from: data)
            diceFaces = try JSONDecoder().decode(DiceFaces.self, from: data)
            results = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
            self.numberOfDice = DiceNumber.two
            self.diceFaces = DiceFaces.six
        }
    }
    
    func save(){
        do{
//            let numberOfDice = try JSONEncoder().encode(self.numberOfDice)
//            let diceFaces = try JSONEncoder().encode(self.diceFaces)
//            let results = try JSONEncoder().encode(self.results)
//            try numberOfDice.write(to: savePath, options: [.atomic, .completeFileProtection])
            
            print("Save")
            print(numberOfDice)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    
    //Codable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numberOfDice = try container.decode(DiceNumber.self, forKey: .numberOfDice)
        diceFaces = try container.decode(DiceFaces.self, forKey: .diceFaces)
        results = try container.decode([Int].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(numberOfDice, forKey: .numberOfDice)
        try container.encode(diceFaces, forKey: .diceFaces)
        try container.encode(results, forKey: .results)
    }
    
}

