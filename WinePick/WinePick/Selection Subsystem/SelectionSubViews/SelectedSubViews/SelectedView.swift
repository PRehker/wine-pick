//
//  SelectedView.swift
//  WinePick
//
//  Created by Philip Rehker on 04.04.24.
//

import SwiftUI

struct SelectedView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    var body: some View {
        ZStack {
            Rectangle()
                .frame(minWidth: 200, maxHeight: 300)
                .foregroundStyle(.red)
            VStack {
                Text(selectionModel.selected.count <= 4 ? "Select four ingredients"
                     : "Only select four ingredients!")
                .foregroundStyle(.primary)
                .font(.title)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectionModel.selected, id: \.self) {item in
                            SelectedItemView(item: item)
                        }
                    }
                }
                .padding()
                if !selectionModel.selected.isEmpty && selectionModel.selected.count <= 4 {
                    NavigationLink(destination: {
                        ResultView()
                    }, label: {
                        Text("Match!")
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 40)
                                .foregroundStyle(.primary))
                    })
                } else {
                    Text("Match!")
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .frame(width: 100, height: 40)
                            .foregroundStyle(.gray))
                }
                Spacer()
            }
        }
        .frame(maxHeight: 300, alignment: .bottom)
        .ignoresSafeArea(.container)
    }
}

#Preview {
    SelectedView().environment(MockSelectionModel() as SelectionModel)
}
