//
//  SelectedItemView.swift
//  WinePick
//
//  Created by Philip Rehker on 08.04.24.
//

import SwiftUI

struct SelectedItemView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    var item: Food
    var body: some View {
        Button(action: {
            selectionModel.removeSelected(foodItem: item)
        }, label: {
            ZStack {
                Image(item.imagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                RoundedRectangle(cornerRadius: 20)
                    .offset(y: 25)
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.red)
                    .opacity(0.8)
                Text(item.name)
                    .frame(width: 100, height: 50)
                    .offset(y: 25)
                    .foregroundStyle(.white)
            }
        })
    }
}
