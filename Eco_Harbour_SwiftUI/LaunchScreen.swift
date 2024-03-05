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
                    
                    Image("screen1bg 1") // Replace with your background image name
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    HStack(spacing: 0) {
                        Text("Eco")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        Text("Track")
                            .foregroundStyle(Color.green)
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    
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
