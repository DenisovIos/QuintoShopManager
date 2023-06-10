//
//  StorageManager.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageManager: ObservableObject {
    static let shared = StorageManager(); private init () { }
    let storage = Storage.storage()
    
    func uploadImage (_ images: [UIImage], _ name: String) {
        for image in images.enumerated() {
            let storageRef = storage.reference().child("\(name)/\(image.offset).jpg")
        }
        
    }
}
