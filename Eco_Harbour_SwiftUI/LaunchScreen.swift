//
//  LaunchScreen.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var showingNextScreen = false
    var body: some View {
        NavigationView{
            ZStack {
                Color.mainGreen.ignoresSafeArea()
                
                VStack {
                    
                    Image("screen1bg") // Replace with your background image name
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    Button("Get Started") {
                        //authenticate user
                        showingNextScreen.toggle()
                        
                    }
                    .foregroundColor(.black)
                    .frame(width:201, height:44)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: OnboardingView(), isActive: $showingNextScreen){
                        EmptyView()
                    }
                    
                    
                }
            }
        }.navigationBarHidden(true)
    }
   
    }


#Preview {
    LaunchScreen()
}
