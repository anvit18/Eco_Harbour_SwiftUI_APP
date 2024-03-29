//
//  ContentView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingNextScreen = false
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color.mainGreen.ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text : $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text : $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        //authenticate user
                        aunthenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.mainGreen)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: SecondView(), isActive: $showingNextScreen){
                        EmptyView()
                    }
                    
                }
                
            }
        }
        .navigationBarHidden(true)
    }
    
    
    func aunthenticateUser(username: String, password: String){
        if username.lowercased() == "anvitpawar"{
            wrongUsername = 0
            if password.lowercased() == "abc12345" {
                wrongPassword = 0
                showingNextScreen = true
            } else {
                wrongPassword = 2
            }
        }else {
            wrongUsername = 2
        }
    }
}
#Preview {
    ContentView()
}
