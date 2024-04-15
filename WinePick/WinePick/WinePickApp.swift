//
//  WinePickApp.swift
//  WinePick
//
//  Created by Philip Rehker on 03.04.24.
//

import SwiftUI

@main
struct WinePickApp: App {
    @State var selectionModel = SelectionModel(categories: [], items: [], wines: [])
    var body: some Scene {
        WindowGroup {
            SelectionOverview()
                .environment(selectionModel)
                .task {
                    await selectionModel.loadData()
                }
        }
    }
}
