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
    
    
    init () {
        productTypeList = TypeOfModel.dataSource
        choosedFilter = TypeOfModel.dataSource[0]
    }
}
