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
                        Text("Harbour")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        //.padding()
                    
                    Button {
                        //authenticate user
                       
                    }label: {
                        HStack{
                            Image("apple").resizable().scaledToFit().ignoresSafeArea()
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width:400, height:60)
                    .background(Color.white)
                    //.border(Color.black, width: 2)
                    .cornerRadius(10)
                    
                    
                    Button {
                        //authenticate user
                       
                    }label: {
                        HStack{
                            Image("google").resizable().scaledToFit().ignoresSafeArea()
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width:400, height:60)
                    .background(Color.white)
                    //.border(Color.black, width: 2)
                    .cornerRadius(10)
                    
                    Text("------------ or ------------")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
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
                    
                    
                    NavigationLink(destination: privateVehicleDetails(), isActive: $showingNextScreen){
                        EmptyView()
                    }
                    
                }
                
            }
//        }
//        .navigationBarHidden(true)
    }
    
    //function to be edited for signup
//    func aunthenticateUser(emailid: String, password: String){
//        if emailid.lowercased() == "anvitpawar"{
//            //wrongUsername = 0
//            if password.lowercased() == "abc12345" {
//               // wrongPassword = 0
//               // showingNextScreen = true
//            } else {
//                //wrongPassword = 2
//            }
//        }else {
//            //wrongUsername = 2
//        }
//    }
}
#Preview {
    signup_page()
}
