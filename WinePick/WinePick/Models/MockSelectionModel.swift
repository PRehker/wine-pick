//
//  MockSelectionModel.swift
//  WinePick
//
//  Created by Philip Rehker on 04.04.24.
//

import Foundation

// create a mock model to use in previews
public class MockSelectionModel: SelectionModel {
    public convenience init() {
        let tomato = Food(name: "Tomato",
                          category: "Nightshades",
                          imagePath: "Tomato",
                          rating: [0, 0, 0, 2, 1, 0, 0, 1, 0])
        let strawberry = Food(name: "Strawberry",
                              category: "Berries",
                              imagePath: "Strawberry",
                              rating: [0, 0, 0, 0, 0, 0, 1, 2, 1])
        let mozarella = Food(name: "Mozarella",
                             category: "Soft Cheese",
                             imagePath: "Mozarella",
                             rating: [0, 1, 2, 1, 2, 1, 1, 1, 1])
        let beef = Food(name: "Beef", category: "Red Meat", imagePath: "Beef", rating: [2, 1, 0, 0, 0, 0, 0, 0, 0])
        let aubergine = Food(
                             name: "Aubergine",
                             category: "Nightshades",
                             imagePath: "Aubergine",
                             rating: [1, 2, 0, 1, 0, 0, 0, 1, 0])
        let foods = [aubergine, beef, mozarella, strawberry, tomato]
        let categories = ["Nightshades", "Berries", "Soft Cheese", "Red Meat"]
        let whiteDry = Wine(type: "whiteDry",
                            tasteProfile:
                                TasteProfile(boldness: 0, tannidity: 1, sweetness: 4, acidity: 3),
                            description: "This wine is good")
        let redDry = Wine(type: "redDry",
                          tasteProfile:
                            TasteProfile(boldness: 1, tannidity: 3, sweetness: 1, acidity: 0),
                          description: "This wine is semigood")
        let wines = [whiteDry, redDry]
        self.init(categories: categories, items: foods, wines: wines)
    }
}
