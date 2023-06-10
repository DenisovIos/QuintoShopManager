//
//  FirestoreService.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService(); private init () { }
    let db = Firestore.firestore()
    
    var typeOfRef: CollectionReference { db.collection("typeOf") }
    var shopCartRef: CollectionReference {db.collection("shopCart") }
    
    
    func getTypeOfModel () async throws -> [TypeOfModel] {
        let snapshot = try await typeOfRef.getDocuments()
        let docs = snapshot.documents
        var typeOf = [TypeOfModel]()
        for doc in docs { if let typeOfProd = TypeOfModel(qdSnap: doc) { typeOf.append(typeOfProd) } }
        return typeOf
        
        
    }
    
    func supportMethod() async throws {
        for typeOf in TypeOfModel.dataSource {
            try await typeOfRef.document(typeOf.id).setData(typeOf.representation)
            print("Данные загружены")
        }
    }
}
