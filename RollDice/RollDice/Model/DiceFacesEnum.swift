//
//  DiceFacesEnum.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

enum DiceFaces: Int, CaseIterable, Identifiable, Codable {
    case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20
    var id: Self { self }
}
