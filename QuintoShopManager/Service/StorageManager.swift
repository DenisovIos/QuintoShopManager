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
    
    func uploadImages (_ images: [UIImage], article: String)  {
        for image in images.enumerated() {
            let storageRef = storage.reference().child("\(article)/\(image.offset).jpg")
            let imageData = image.element.jpegData(compressionQuality: 0.5)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            if let data = imageData {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        print("Error while uploading file: ", error)
                    }
                    
                    if let metadata = metadata {
                        print("Metadata: ", metadata)
                    }
                }
            }
        }
        
    }
    func uploadImageBlank (article: String)  {
        let storageRef = storage.reference().child("\(article)/0.jpg")
        let image = UIImage(named: "blankPhoto")
        let imageData = image?.jpegData(compressionQuality: 0.5)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        if let data = imageData {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
        
        
    }
    
    func downloadImages (_ article: String) async throws -> [UIImage] {
        var result = [UIImage]()
        let islandRef = storage.reference().child("\(article)/0.jpg")
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("image is empty")
            } else {
                print("получаем дату")
                guard let data else { return }
                print("делаем дату красивой")
                guard let image = UIImage(data: data) else { return }
                print("делаем дату картинкой")
                result.append(image)
                print("Добавили в массив")
            }
        }
        
        return result
        
    }
}
