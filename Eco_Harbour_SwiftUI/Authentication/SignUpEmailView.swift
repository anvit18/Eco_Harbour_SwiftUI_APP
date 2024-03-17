//
//  SignInEmailView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by Sarthak_AppDev on 11/03/24.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    @Published var email=""
    @Published var password=""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pass found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    }
}

struct SignUpEmailView: View {
    
    @StateObject private var viewModel=SignUpEmailViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        VStack{
            TextField("Email....", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            SecureField("Password....", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button{
                Task{
                    do{
                        try await viewModel.signIn()
                        showSignInView=false
                    }catch{
                        print("error \(error)")
                    }
                }
                
                
            } label:{
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign up with email")
    }
}

#Preview {
    SignUpEmailView(showSignInView: .constant(false))
}
