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
    
    
    
    func getProductPhotos (_ productID: String) async throws -> [ProductPhotoModel] {
        let snapshot = try await productRef.document(productID).collection("photos").getDocuments()
        let docs = snapshot.documents
        var photos = [ProductPhotoModel]()
        for doc in docs { if let productPhoto = ProductPhotoModel(qdSnap: doc) { photos.append(productPhoto) } }
        return photos
    }
    
    func getAllProducts () async throws -> [ProductModel] {
        let snapshot = try await productRef.getDocuments()
        let docs = snapshot.documents
        var products = [ProductModel]()
        for doc in docs {
            if let product = try await ProductModel(qdSnap: doc) {products.append(product)}
        }
        return products
    }
}
