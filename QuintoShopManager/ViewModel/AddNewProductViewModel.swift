//
//  AddNewProductViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation
import PhotosUI
import SwiftUI

class AddNewProductViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var price: String = ""
    @Published var article: String = ""
    @Published var images: [String] = []
    @Published var type: TypeOfModel = TypeOfModel.dataSource[0]
    @Published var quantity: String = ""
    @Published var showOk: Bool = false
    
    var productTypeList : [TypeOfModel]
    
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedImages =  [UIImage]()
  
    
    func removeImage(_ image: UIImage) {
        let result = selectedImages.filter { img in
            img != image
        }
        selectedImages = result
    }
    
    func clearAll() {
        name = ""
        description = ""
        price = ""
        article = ""
        images = []
        type = TypeOfModel.dataSource[0]
        quantity = ""
        selectedImages = []
        selectedItems = []
    }
    
    init () {
        productTypeList = TypeOfModel.dataSource
    }
}
