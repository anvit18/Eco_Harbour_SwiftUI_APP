//
//  AuthenticationManager.swift
//  Eco_Harbour_SwiftUI
//
//  Created by Sarthak_AppDev on 11/03/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid:String
    let email:String?
    let photUrl:String?
    
    init(user:User){
        self.uid=user.uid
        self.email=user.email
        self.photUrl=user.photoURL?.absoluteString
    }
}

final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){ }
    
    
    // Creating new user
    func createUser(email:String,password:String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    // Getting authenticated user
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // sign out user
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
}
