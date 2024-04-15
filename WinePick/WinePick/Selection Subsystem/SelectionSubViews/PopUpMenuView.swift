//
//  PopUpMenuView.swift
//  WinePick
//
//  Created by Philip Rehker on 09.04.24.
//

import SwiftUI

struct PopUpMenuView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    @Binding var isListView: Bool
    @Binding var isDarkMode: Bool
    var body: some View {
        Menu(content: {
            Button("Show List", action: {
                isListView = true
            })
            Button("Show Categories", action: {
                isListView = false
            })
            Button(action: {
                isDarkMode.toggle()
            }, label: {
                HStack {
                    Text(isDarkMode ? "Switch to light mode" : "Switch to dark mode")
                    Image(systemName: isDarkMode ? "moon.circle" : "sun.max.circle")
                }
            })
        }, label: {
            Image(systemName: "list.bullet")
                .foregroundStyle(isDarkMode ? .white : .black)
        })
        .padding()
    }
}

#Preview {
    PopUpMenuView(isListView: .constant(false), isDarkMode: .constant(true))
}
