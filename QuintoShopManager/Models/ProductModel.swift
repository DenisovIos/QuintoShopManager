//
//  ProductModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation

struct ProductModel: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var price: Int
    var article: String
    var imageUrl: String
    var type: TypeOfModel
    var quantity: Int
}

extension ProductModel {
    
}
