//
//  AuthenticationView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by Sarthak_AppDev on 11/03/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView:Bool
    
    var body: some View {
        VStack{
            
            NavigationLink{
                SignUpEmailView(showSignInView: $showSignInView)
            } label:{
                Text("Sign Up with email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}
