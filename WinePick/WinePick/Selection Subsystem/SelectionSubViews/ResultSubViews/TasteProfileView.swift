//
//  TasteProfileView.swift
//  WinePick
//
//  Created by Philip Rehker on 08.04.24.
//

import SwiftUI

struct TasteProfileView: View {
    var tasteProfile: TasteProfile

    var body: some View {
        VStack {
            TasteAttributeView(attribute1: "Bold", attribute2: "Light", value: tasteProfile.boldness)
            TasteAttributeView(attribute1: "Tannic", attribute2: "Smooth", value: tasteProfile.tannidity)
            TasteAttributeView(attribute1: "Sweet", attribute2: "Dry", value: tasteProfile.sweetness)
            TasteAttributeView(attribute1: "Acidic", attribute2: "Soft", value: tasteProfile.acidity)
        }
    }
}

struct TasteAttributeView: View {
    var attribute1: String
    var attribute2: String
    var value: Int

    private let markerWidth = 30
    private let positions: [CGFloat] = [15 / 375, 0.25 + 15 / 375, 0.5, 0.75 - 15 / 375, 1 - 15 / 375]

    var body: some View {
        HStack {
            Text(attribute2)
                .frame(width: 60)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 30, height: 10)
                        .foregroundColor(.red)
                        .position(x: positions[value] * geometry.size.width)
                }
            }
            Text(attribute1)
                .frame(width: 60)
        }
        .padding()
        .frame(height: 20)
    }
}

#Preview {
    TasteProfileView(tasteProfile: TasteProfile(boldness: 0, tannidity: 1, sweetness: 3, acidity: 4))
}
