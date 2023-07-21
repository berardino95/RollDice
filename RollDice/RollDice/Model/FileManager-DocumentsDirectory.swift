//
//  FileManager-DocumentsDirectory.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
