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
    var productRef: CollectionReference {db.collection("products") }
    
    
    func getTypeOfModel () async throws -> [TypeOfModel] {
        let snapshot = try await typeOfRef.getDocuments()
        let docs = snapshot.documents
        var typeOf = [TypeOfModel]()
        for doc in docs { if let typeOfProd = TypeOfModel(qdSnap: doc) { typeOf.append(typeOfProd) } }
        return typeOf
        
        
    }
    
//    func supportMethod() async throws {
//        for typeOf in TypeOfModel.dataSource {
//            try await typeOfRef.document(typeOf.id).setData(typeOf.representation)
//            print("Данные загружены")
//        }
//    }
    
    func addNewProduct(_ product: ProductModel,_ photos: [ProductPhotoModel]) async throws {
            do {
                try await productRef.document(product.id).setData(product.representation)
                for photo in photos{
                    try await productRef.document(product.id).collection("photos").document("\(photo.id)").setData(photo.representation)
                }
                
                
            } catch {
                throw error
            }
    }
    
    
    
    func getProductPhotos (_ product: ProductModel)async throws -> [ProductPhotoModel] {
        let snapshot = try await productRef.document(product.id).collection("photos").getDocuments()
        let docs = snapshot.documents
        var photos = [ProductPhotoModel]()
        for doc in docs { if let productPhoto = ProductPhotoModel(qdSnap: doc) { photos.append(productPhoto) } }
        return photos
    }
}
