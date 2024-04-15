//
//  SelectionListView.swift
//  WinePick
//
//  Created by Philip Rehker on 07.04.24.
//

import SwiftUI

struct SelectionListView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    var body: some View {
        let dict = selectionModel.getSectionedDictionary()
        List {
            ForEach(dict.keys.sorted(), id: \.self) { key in
                if let itemsOfKey = dict[key] {
                    Section(header: Text("\(key)")) {
                        ForEach(itemsOfKey) { item in
                            ListIngredientView(item: item)
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
    }
}
