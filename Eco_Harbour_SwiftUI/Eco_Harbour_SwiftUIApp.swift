//
//  Eco_Harbour_SwiftUIApp.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI
import Firebase

@main
struct Eco_Harbour_SwiftUIApp: App {
    
    @StateObject private var userData = UserData()
    @StateObject private var distanceViewModel = DistanceViewModel()
    
    init(){
            FirebaseApp.configure()
            print("Firebase configured")
        }

    var body: some Scene {
        WindowGroup {
            RootView()
//            SplashScreen()
//                .environmentObject(userData)
//                .environmentObject(distanceViewModel)
        }
    }
}
