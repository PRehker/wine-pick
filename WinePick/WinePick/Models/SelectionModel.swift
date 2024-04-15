//
//  SelectionModel.swift
//  WinePick
//
//  Created by Philip Rehker on 04.04.24.
//

import Foundation
import os
import SwiftUI

// SelectionModel
/// The model to manage selection and addition of Food items
@Observable public class SelectionModel: ObservableObject {
    private let logger = Logger()
    public var categories: [String]
    var items: [Food]
    var wines: [Wine]
    var selected: [Food]
    var loadedData = false
    init(categories: [String], items: [Food], wines: [Wine]) {
        self.categories = categories
        self.items = items
        self.wines = wines
        self.selected = []
    }
    // Function to search in items
    /// - Parameters:
    ///     - foodName: Name of the Item to be searched
    ///     - returns Food if found, else nil
    func search(foodName: String) -> Food? {
        return items.first(where: { $0.name == foodName.lowercased() })
    }
    // Function to add new Items
    /// - Parameters:
    ///     - foodItem: the Item to be added directly
    func add(foodItem: Food) {
        items.append(foodItem)
    }
    // Function to select an item
    /// - Parameters:
    /// - foodItem: the Item to be selected
    func select(foodItem: Food) {
        selected.append(foodItem)
    }
    // Function to remove Item from selection
    /// - Parameters:
    /// - foodItem: Item to be removed
    func removeSelected(foodItem: Food) {
        if selected.contains(foodItem) {
            selected.removeAll(where: {
                $0 == foodItem
            })
        } else {
            print("No such item found!")
        }
    }
    // Function to get all items of a certain category
    /// - Parameters:
    /// - category: Name of the Category
    /// - Returns: List of all Food items that have the wanted
    func getItemsOfCategory(category: String) -> [Food] {
        return items.filter { $0.category == category }
    }
    // Function to get all Food ingredients sorted
    /// - Returns:List of sorted "Food"-items
    func sortedItems() -> [Food] {
        return items.sorted()
    }
    // Function to get all categories sorted
    /// - Returns: List of all categories alphabetically
    func sortedCategories() -> [String] {
        return categories.sorted()
    }
    // Function to get all Items sorted by alphabetical Order
    /// - Returns: Dictionary of each Food Item with its corresponding first letter
    func getSectionedDictionary() -> [String: [Food]] {
        let sectionDictionary: [String: [Food]] = {
            return Dictionary(grouping: items, by: {
                let name = $0.name
                let normalisedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let firstChar = String(normalisedName.first ?? Character("")).uppercased()
                return firstChar
            })
        }()
        return sectionDictionary
    }
    // Function to fetch Data from API
    func loadData() async {
        let decoder = JSONDecoder()
        var items: [Food] = []
        var wines: [Wine] = []
        do {
            if let foodURL = Bundle.main.url(forResource: "Models/JSONContent/Food", withExtension: "json"),
               let wineURL = Bundle.main.url(forResource: "Models/JSONContent/Wine", withExtension: "json") {
                let foodData = try Data(contentsOf: foodURL)
                let wineData = try Data(contentsOf: wineURL)
                items = try decoder.decode([Food].self, from: foodData)
                wines = try decoder.decode([Wine].self, from: wineData)
                
            }
            var categories: [String] = []
            for item in items where !categories.contains(item.category) {
                categories.append(item.category)
            }
            self.categories = categories
            self.items = items
            self.wines = wines
            loadedData = true
        } catch {
            self.logger.log("Error occured while trying to decode ingredients from JSON: \(error, privacy: .public)")
        }
    }
    // Function to calculate the result based on selected ingredients
    /// - returns: Dictionary with the wine mapped to the percentage of fit
    func getResultWines() -> [Wine] {
        var resultArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for item in selected {
            resultArray = zip(resultArray, item.rating).map(+)
        }
        var bestWines: [Wine] = []
        var index = 0
        for rating in resultArray {
            if rating > selected.count {
                bestWines.append(wines[index])
            }
            index += 1
        }
        logger.log("Calculated result: \(bestWines, privacy: .public)")
        return bestWines
    }
    // Function to get the directory of documents
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    // Function to save images to directory
    func saveImageToFile(image: UIImage, name: String) -> String? {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name).png")
            try? data.write(to: filename)
            logger.log("Added new image at path: \(filename, privacy: .public)")
            return try? String(contentsOf: filename)
        }
        return nil
    }
}
