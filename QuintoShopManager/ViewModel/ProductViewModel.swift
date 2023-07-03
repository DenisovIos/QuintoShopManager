//
//  ProductViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 03.07.2023.
//

import Foundation
import PhotosUI
import SwiftUI
import UIKit

class ProductViewModel: ObservableObject {
    @Published var product: ProductModel
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var price: String = ""
    @Published var article: String = ""
    @Published var images: [String] = []
    @Published var type: TypeOfModel = TypeOfModel.dataSource[0]
    @Published var quantity: String = ""
    @Published var showOk: Bool = false
    @Published var showEdit = false
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
    func changeAll() {
        name = product.name
        description = product.description
        price = product.price
        article = product.article
        quantity = product.quantity
        Task {
            let photos = try await StorageManager.shared.downloadImages(product)
            DispatchQueue.main.async {
                self.selectedImages = photos
            }
        }
    }
    init() {
        self.product = ProductModel(name: "Guitar", description: "test test teste testetstetstetstetstetstest", price: "231", article: "GB212412", type: "", quantity: "1", photos: [])
        productTypeList = TypeOfModel.dataSource
    }
}
