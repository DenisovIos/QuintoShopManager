//
//  AuthViewModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var login: String = "shopquinto@gmail.com"
    @Published var password : String = "QuintoShop1ForeverManager"
    @Published var check = false
    @Published var needHelp = false
    
}
