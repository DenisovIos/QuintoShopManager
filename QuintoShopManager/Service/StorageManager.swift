//
//  StorageManager.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation
import FirebaseStorage
import Firebase
import UIKit

class StorageManager: ObservableObject {
    static let shared = StorageManager(); private init () { }
    let storage = Storage.storage()
    
    func uploadImages (_ images: [UIImage],_ article: String) -> [ProductPhotoModel]  {
        var productImages = [ProductPhotoModel]()
        for image in images{
            let imageModel = PhotoModel(image: image)
            let storageRef = storage.reference().child("\(article)/\(imageModel.id).jpg")
            let imageData = image.jpegData(compressionQuality: 0.5)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            if let data = imageData {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        print("Error while uploading file: ", error)
                    }
                    
                    if let metadata = metadata {
                        print(metadata)
                        productImages.append(ProductPhotoModel(id: imageModel.id, bucket: article))
                    }
                }
            }
        }
        return productImages
        
    }
    
    
    
    func downloadImages (_ product: ProductModel) async throws -> [UIImage] {
        var result = [UIImage]()
        let productPhotos = try await FirestoreService.shared.getProductPhotos(product)
        for photo in productPhotos {
            let storageRef =  storage.reference().child("\(photo.bucket)/\(photo.id).jpg")
            do {
                let data = try await storageRef.data(maxSize: 1 * 1024 * 1024)
                guard let image = UIImage(data: data) else { throw StorageErrors.badData}
                result.append(image)
            } catch {
                throw StorageErrors.badFetchData
            }
            
        }
        return result
    }
    
    
}




enum StorageErrors: Error {
    case badData
    case badFetchData
}
