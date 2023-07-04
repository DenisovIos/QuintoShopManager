//
//  ProductListViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var productTypeList: [TypeOfModel]
    @Published var choosedFilter: TypeOfModel
    @Published var searchArticle: String = ""
    var allProducts: [ProductModel]
    @Published var showedProducts : [ProductModel]
    @Published var showProduct = false
    
    func getAllProducts () async throws{
        let products = try await FirestoreService.shared.getAllProducts()
        DispatchQueue.main.async {
            self.allProducts = products
            self.showedProducts = products
        }
        
    }
    
    func filter() {
        
    }
    
    init () {
        productTypeList = TypeOfModel.dataSource
        choosedFilter = TypeOfModel.dataSource[0]
        allProducts = []
        showedProducts = []
    }
}
