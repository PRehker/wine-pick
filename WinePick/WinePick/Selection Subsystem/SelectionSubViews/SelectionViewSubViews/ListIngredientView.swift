//
//  ListIngredientView.swift
//  WinePick
//
//  Created by Philip Rehker on 07.04.24.
//

import SwiftUI

struct ListIngredientView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    var item: Food
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Button(action: {
                if selectionModel.selected.contains(item) {
                    selectionModel.removeSelected(foodItem: item)
                } else {
                    selectionModel.select(foodItem: item)
                }
            }, label: {
                Image(systemName: selectionModel.selected.contains(item) ? "checkmark.square" : "square")
            })
        }
    }
}
