//
//  ProductViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var productTypeList: [TypeOfModel]
    @Published var choosedFilter: TypeOfModel
    
}
