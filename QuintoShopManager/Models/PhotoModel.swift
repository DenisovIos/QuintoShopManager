//
//  PhotoModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation

import Foundation
import FirebaseFirestore

struct PhotoModel: Identifiable {
    var id: String = UUID().uuidString
    var url: String
}

extension PhotoModel {
    init?(qdSnap: QueryDocumentSnapshot) {
        let data = qdSnap.data()
        guard let id = data["id"] as? String,
              let url = data["url"] as? String else { return nil }
        self.id = id
        self.url = url
    }
}

extension PhotoModel: Hashable { }


extension PhotoModel {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["url"] = url
        return repres
    }
}
