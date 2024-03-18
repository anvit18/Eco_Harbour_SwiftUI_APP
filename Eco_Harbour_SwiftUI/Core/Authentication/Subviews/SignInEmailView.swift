//
//  SignInEmailView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by Sarthak_AppDev on 11/03/24.
//

import SwiftUI

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

struct SignInEmailView: View {
    
    @StateObject private var viewModel=SignInEmailViewModel()
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
                    
                    //for sign in
                    do{
                        try await viewModel.signIn()
                        showSignInView=false
                        return
                    }catch{
                        print("error \(error)")
                    }
                }
                
                
            } label:{
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Log in with email")
    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
