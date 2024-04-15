//
//  ResultTabView.swift
//  WinePick
//
//  Created by Philip Rehker on 08.04.24.
//

import SwiftUI

struct ResultTabView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    var wine: Wine
    var body: some View {
        VStack {
            Text(wine.type)
                .font(.title)
            TasteProfileView(tasteProfile: wine.tasteProfile)
            Text(wine.description)
        }
    }
}

#Preview {
    ResultTabView(wine: Wine(type: "Bold Red",
                             tasteProfile: TasteProfile(boldness: 0, tannidity: 1, sweetness: 2, acidity: 3),
                             description: "Good overall choice"))
        .environment(MockSelectionModel() as SelectionModel)
}
