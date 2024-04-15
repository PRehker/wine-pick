//
//  Food.swift
//  WinePick
//
//  Created by Philip Rehker on 03.04.24.
//

import Foundation

// Food
/// One single ingredient
struct Food {
    let id: UUID
    var name: String
    var category: String
    var imagePath: String
    var rating: [Int]
    enum CodingKeys: String, CodingKey {
        case name, category, rating
        case integerID = "id"
    }
    init(name: String, category: String, imagePath: String, rating: [Int]) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.imagePath = imagePath
        self.rating = rating
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imagePath = name
        category = try container.decode(String.self, forKey: .category)
        rating = try container.decode([Int].self, forKey: .rating)
        id = UUID()
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(rating, forKey: .rating)
    }
}

// Extension to provide sorting capabilities
extension Food: Comparable, Hashable, Codable, Identifiable {
    static func < (lhs: Food, rhs: Food) -> Bool {
        lhs.name < rhs.name
    }
}
