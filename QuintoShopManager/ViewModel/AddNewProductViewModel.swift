//
//  AddNewProductViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation

class AddNewProductViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var price: String = ""
    @Published var article: String = ""
    @Published var images: [String] = []
    @Published var type: TypeOfModel = TypeOfModel.dataSource[0]
    @Published var quantity: Int = 1
    
    var productTypeList : [TypeOfModel]
  
    init () {
        productTypeList = TypeOfModel.dataSource
    }
}
