//
//  Wine.swift
//  WinePick
//
//  Created by Philip Rehker on 03.04.24.
//

import Foundation

struct Wine {
    var id: UUID
    var type: String
    var tasteProfile: TasteProfile
    var description: String
    enum CodingKeys: String, CodingKey {
        case type, tasteProfile, description
        case integerID = "id"
    }
    init(type: String, tasteProfile: TasteProfile, description: String) {
        self.id = UUID()
        self.type = type
        self.tasteProfile = tasteProfile
        self.description = description
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        tasteProfile = try container.decode(TasteProfile.self, forKey: .tasteProfile)
        description = try container.decode(String.self, forKey: .description)
        id = UUID()
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(tasteProfile, forKey: .tasteProfile)
        try container.encode(description, forKey: .description)
    }
}

extension Wine: Codable { }
