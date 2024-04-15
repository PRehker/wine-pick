//
//  SelectionCategoryView.swift
//  WinePick
//
//  Created by Philip Rehker on 04.04.24.
//

import SwiftUI

// MARK: SelectionCategoryView
/// Shows all ingredients sorted by their categories
struct SelectionCategoryView: View {
    @Environment(SelectionModel.self) var selectionModel: SelectionModel
    var body: some View {
        VStack {
            let categories = selectionModel.sortedCategories()
            ForEach(categories, id: \.self) { category in
                HStack {
                    Text(category)
                        .font(.title2)
                        .padding(.horizontal)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectionModel.getItemsOfCategory(category: category), id: \.self) { item in
                            CategoryIngredientView(item: item)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SelectionCategoryView().environment(MockSelectionModel() as SelectionModel)
}
