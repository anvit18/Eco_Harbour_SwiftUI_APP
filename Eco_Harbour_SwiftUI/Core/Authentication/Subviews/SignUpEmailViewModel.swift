//
//  SignUpEmailViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/03/24.
//

import Foundation

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    @Published var email=""
    @Published var password=""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pass found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    }
}
