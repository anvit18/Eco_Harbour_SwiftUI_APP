//
//  ContentView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI

struct Login_Signup_Page: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingNextScreen = false
    @State private var showingSignUpScreen = false
    
    var body: some View {
        
        
            ZStack{
                
                Color.mainGreen.ignoresSafeArea()
                
                    
                
                Circle()
                    .scale(1.8)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.5)
                    .foregroundColor(.white)
                VStack{
                    
                    //logo EcoHarbour
                    HStack(spacing: 0){
                        Text("Eco").font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                        Text("Harbour")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .bold()
                        
                    }
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text : $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text : $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.gray)
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
                    
                    NavigationLink(destination: homePageDashboard(), isActive: $showingNextScreen){
                        EmptyView()
                    }
                    HStack{
                        Spacer()
                        Button("New User ?"){
                            //add code
                            showingSignUpScreen.toggle()
                        }
                        .foregroundColor(.blue)
                        .background(.white)
                        .padding(.horizontal, 40)
                        .font(.callout)
                        .frame(alignment: .trailing)
                        .padding(.trailing, 8)
                        
                        NavigationLink(destination: signup_page(), isActive: $showingSignUpScreen){
                            EmptyView()
                        }
                    }
                }
                
            }
        
      //  .navigationBarHidden(false)
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
    Login_Signup_Page()
}
