//
//  AuthService.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    private init() {}
    
    func login(email: String?,
               password: String?,
               completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            return
        }

        auth.signIn(withEmail: email, password: password) { result, error in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func signOut() {
        try! auth.signOut()
    }
    
    
    func reg(email: String?, password: String?, confirm: String?, completion: @escaping (Result<User,Error>) -> Void) {
        
        guard let email = email, let password = password, let confirm = confirm else {
            return
        }
        
        guard password == confirm else {
            return
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
            
        }


    }
}
