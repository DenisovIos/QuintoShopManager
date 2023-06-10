//
//  ShopingCartModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation


struct ShopingCartModel: Identifiable {
    var id = UUID().uuidString
    var shopingCart: [ProductModel]
    var name: String
    var number: Int
    var time: Date
}
