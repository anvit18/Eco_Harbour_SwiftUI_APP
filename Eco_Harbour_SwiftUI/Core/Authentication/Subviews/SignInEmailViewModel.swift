//
//  SignInEmailViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/03/24.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject{
    @Published var email=""
    @Published var password=""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pass found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }
}
