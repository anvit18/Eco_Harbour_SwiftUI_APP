//
//  Eco_Harbour_SwiftUIApp.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI

@main
struct Eco_Harbour_SwiftUIApp: App {
    
    @StateObject private var userData = UserData()
    @StateObject private var distanceViewModel = DistanceViewModel()

    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .environmentObject(userData)
                .environmentObject(distanceViewModel)
        }
    }
}
