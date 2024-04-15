//
//  WineTasteProfile.swift
//  WinePick
//
//  Created by Philip Rehker on 03.04.24.
//

import Foundation

public struct TasteProfile: Codable {
    var boldness: Int
    var tannidity: Int
    var sweetness: Int
    var acidity: Int
}
