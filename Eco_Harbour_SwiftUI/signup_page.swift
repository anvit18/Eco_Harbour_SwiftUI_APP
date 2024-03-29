//
//  ContentView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI

struct signup_page: View {
    
    @State private var emailid = ""
    @State private var password = ""
    @State private var showingNextScreen = false
    
    
    var body: some View {
        
        
            ZStack{
                
                Color.mainGreen.ignoresSafeArea()
                
                    
                Circle()
                    .scale(1.9)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                VStack{
                    
                    //logo EcoHarbour
                    HStack(spacing: 0){
                        Text("Eco").font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                        Text("Track")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        //.padding()
                    
        
                    
                    
                    
                    TextField("Enter Email", text : $emailid)
                        .padding()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.gray)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        //.border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Enter Password", text : $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.gray)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        //.border(.red, width: CGFloat(wrongPassword))
                    
                    SecureField("Confirm Password", text : $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.gray)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        //.border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Sign Up") {
                        showingNextScreen.toggle()
                        //authenticate user
                        //aunthenticateUser(username: emailid, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.mainGreen)
                    .cornerRadius(10)
                    
                    
                    NavigationLink(destination: recordView(showSignInView: .constant(false)), isActive: $showingNextScreen){
                        EmptyView()
                    }
                    
                }
                
            }
//        }
 .navigationBarHidden(true)
    }
    
}
#Preview {
    signup_page()
}
