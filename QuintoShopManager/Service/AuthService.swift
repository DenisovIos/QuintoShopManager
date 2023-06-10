//
//  AuthService.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService(); private init() { }
    let auth = Auth.auth()
    var currentUser : User?
    
    func signIn(login: String,
                password: String) async throws -> Bool{
        let result = try await auth.signIn(withEmail: login, password: password)
        currentUser = result.user
        return check()
    }
    
    func signOut() {
        try! auth.signOut()
    }
    
    
    func check() -> Bool {
        guard let user = currentUser else {return false}
        let result = user.uid == "3VNP7HFWYWNhaD5lYsLOo3QJeN13" ? true : false
        return result
    }
    
}
