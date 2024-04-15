//
//  SelectionOverview.swift
//  WinePick
//
//  Created by Philip Rehker on 03.04.24.
//

import SwiftUI

struct SelectionOverview: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    @Environment(\.colorScheme) private var colorScheme
    @State var isListView = false
    @State var searchText = ""
    @State var showAddPopover = false
    @State var showOptionMenu = false
    @State var isDarkMode = false
    // Body
    var body: some View {
        if selectionModel.loadedData {
            NavigationStack {
                VStack {
                    ScrollView(.vertical) {
                        ZStack {
                            SelectionCategoryView()
                                .opacity(isListView ? 0 : 1)
                            SelectionListView()
                                .opacity(isListView ? 1 : 0)
                                .searchable(text: $searchText)
                        }
                    }
                    if !selectionModel.selected.isEmpty {
                        SelectedView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showAddPopover.toggle()
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        PopUpMenuView(isListView: $isListView, isDarkMode: $isDarkMode)
                    }
                }
                .navigationTitle(isListView ? "List" : "Categories")
            }
            .popover(isPresented: $showAddPopover, content: {
                AddIngredientView()
            })
            .preferredColorScheme(isDarkMode ? .dark : .light)
        } else {
            Text("Data did not initialise! Try reloading app...")
        }
    }
}

#Preview {
    SelectionOverview().environment(MockSelectionModel() as SelectionModel)
}
