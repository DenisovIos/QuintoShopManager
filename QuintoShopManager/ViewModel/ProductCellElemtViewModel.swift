//
//  ProductCellElemtViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 03.07.2023.
//

import Foundation
import UIKit

class ProductCellElemtViewModel: ObservableObject {
    @Published var product: ProductModel
    @Published var photos: [UIImage]
    
    func GetImages () async throws {
        if product.photos.count > 0 {
            Task {
                let photos = try await StorageManager.shared.downloadImages(product)
                DispatchQueue.main.async {
                    self.photos = photos
                }
            }
        }
    }
    
    init() {
        self.product = ProductModel(name: "Guitar", description: "test test teste testetstetstetstetstetstest", price: "231", article: "GB212412", type: "", quantity: "1", photos: [])
        self.photos = []
    }
    
}
