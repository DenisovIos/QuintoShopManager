//
//  PhotoModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation
import FirebaseFirestore
import UIKit

struct PhotoModel: Identifiable {
    var id: String = UUID().uuidString
    var image: UIImage
}

extension PhotoModel: Hashable {}
