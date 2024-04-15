//
//  AddIngredientView.swift
//  WinePick
//
//  Created by Philip Rehker on 09.04.24.
//

import SwiftUI
import ImagePickerModule

struct AddIngredientView: View {
    @Environment(SelectionModel.self) private var selectionModel: SelectionModel
    @State var foodName = ""
    @State var category = 0
    @State var image: UIImage?
    @State var rating = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $foodName)
                Picker("Category", selection: $category, content: {
                    ForEach(selectionModel.categories, id: \.self) { category in
                        Text(category)
                    }
                })
                ImagePickerButton(selectedImage: $image) {
                    Image(systemName: "photo")
                }
            }
            Button(action: {
                let unwrappedImage = image ?? UIImage.remove
                let imagePath = selectionModel.saveImageToFile(image: unwrappedImage, name: foodName) ?? ""
                if image != nil &&
                    !imagePath.isEmpty &&
                    selectionModel.saveImageToFile(image: image ?? UIImage.remove, name: foodName) != nil &&
                    !foodName.isEmpty &&
                    rating != [0, 0, 0, 0, 0, 0, 0, 0, 0] {
                    selectionModel.add(foodItem: Food(name: foodName,
                                                      category: selectionModel.categories[category],
                                                      imagePath: imagePath,
                                                      rating: rating))
                }
            }, label: {
                Text("Add Ingredient")
                    .offset(y: 10)
                    .font(.custom("Borel-Regular", size: 24))
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .frame(width: 250)
                        .foregroundStyle(.gray))
            })
        }
    }
}
