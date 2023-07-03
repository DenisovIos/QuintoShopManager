//
//  ProductPhotoModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 13.06.2023.
//

import Foundation

import Foundation
import FirebaseFirestore

struct ProductPhotoModel: Identifiable {
    var id: String
    var bucket: String
}


extension ProductPhotoModel {
    var representation : [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["bucket"] = self.bucket
        return dict
    }
}


extension ProductPhotoModel {
    
    init?(qdSnap: QueryDocumentSnapshot) {
        let data = qdSnap.data()
        guard let id = data["id"] as? String,
              let bucket = data["bucket"] as? String else { return nil }
        self.id = id
        self.bucket = bucket
    }
}
