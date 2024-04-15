//
//  CategoryIngredientView.swift
//  WinePick
//
//  Created by Philip Rehker on 04.04.24.
//

import SwiftUI

// MARK: CategoryIngredientView
/// View to display a single Ingredient
/// - pass a single Food Item to this view
struct CategoryIngredientView: View {
    @Environment(SelectionModel.self) var selectionModel: SelectionModel
    var item: Food
    var body: some View {
        ZStack {
            Image(item.imagePath)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.leading)
            RoundedRectangle(cornerRadius: 20)
                .offset(y: 25)
                .frame(width: 100, height: 50)
                .foregroundStyle(selectionModel.selected.contains(item) ? .red : .gray)
                .opacity(0.8)
                .padding(.leading)
            Text(item.name)
                .frame(width: 100, height: 50)
                .offset(y: 25)
                .foregroundStyle(.white)
                .padding(.leading)
        }
        .onTapGesture(perform: {
            if selectionModel.selected.contains(item) {
                selectionModel.removeSelected(foodItem: item)
            } else {
                selectionModel.select(foodItem: item)
            }
        })
    }
}

#Preview {
    CategoryIngredientView(item:
                            Food(name: "Strawberry",
                                 category: "Berries",
                                 imagePath: "Strawberry",
                                 rating: [0, 0, 0, 2, 1, 0, 0, 1, 0]))
                                    .environment(MockSelectionModel() as SelectionModel)
}
