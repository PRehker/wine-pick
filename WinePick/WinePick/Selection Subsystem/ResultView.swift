//
//  ResultView.swift
//  WinePick
//
//  Created by Philip Rehker on 08.04.24.
//

import SwiftUI

struct ResultView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    @State private var selectedTab = 1
    var body: some View {
        let resultingWines = selectionModel.getResultWines()
        if !resultingWines.isEmpty {
            VStack {
                HStack {
                    ForEach(1...resultingWines.count, id: \.self) { index in
                        Button(action: {
                            self.selectedTab = index
                        }, label: {
                            HStack {
                                Image(systemName: selectedTab == index ? "wineglass.fill" : "wineglass")
                                Text("\(resultingWines[index - 1].type)")
                                    .font(.custom("Borel-Regular", size: 18))
                                    .offset(y: 5)
                            }
                            .padding()
                            .background(self.selectedTab == index ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        })
                    }
                }
                switch selectedTab {
                case 1:
                    ResultTabView(wine: resultingWines[0])
                case 2:
                    ResultTabView(wine: resultingWines[1])
                case 3:
                    ResultTabView(wine: resultingWines[2])
                case 4:
                    ResultTabView(wine: resultingWines[3])
                default:
                    Text("Unknown Tab")
                }
            }
        } else {
            Text("Sorry, no match available! Try with another selection.")
        }
    }
}

#Preview {
    ResultView().environment(MockSelectionModel() as SelectionModel)
}
