//
//  ProductModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation
import FirebaseFirestore

struct ProductModel: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var price: String
    var article: String
    var type: String
    var quantity: String
    var photos : [ProductPhotoModel]
}

extension ProductModel {
    
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["description"] = self.description
        dict["price"] = self.price
        dict["article"] = self.article
        dict["type"] = self.type
        dict["quantity"] = self.quantity
        return dict
    }
    
    init?(data: [String: Any]) async throws {
        
        guard let id: String = data["id"] as? String,
              let description: String = data["description"] as? String,
              let name: String = data["name"] as? String,
              let price: String = data["price"] as? String,
              let article: String = data["article"] as? String,
              let type: String = data["type"] as? String,
              let quantity: String = data["quantity"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.article = article
        self.type = type
        self.quantity = quantity
        self.photos = try await FirestoreService.shared.getProductPhotos(id)
    }
    
}


extension ProductModel {
    
    init?(qdSnap: QueryDocumentSnapshot) async throws {
        let data = qdSnap.data()
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let description = data["name"] as? String,
              let price = data["price"] as? String,
              let article = data["article"] as? String,
              let type = data["type"] as? String,
              let quantity = data["quantity"] as? String else { return nil }
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.article = article
        self.type = type
        self.quantity = quantity
        self.photos = try await FirestoreService.shared.getProductPhotos(id)
    }
}
