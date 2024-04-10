//
//  Eco_Harbour_SwiftUIApp.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI
import Firebase

class VehicleTypeDataProvider: ObservableObject {
    // Define your properties and methods here
    // For example:
    @Published var last14DaysData: [(name: String, emissions: Int)] = [
        (name: "Car", emissions: 916),
        (name: "Bus", emissions: 820),
        (name: "Auto", emissions: 610),
        (name: "Train", emissions: 350),
    ]

    init() {
        // You can initialize any properties or perform setup here
        // For example, you might fetch data from a database or web service
    }
}
class EmissionDataViewModelWrapper: ObservableObject {
    @Published var emissionDataViewModel = EmissionDataViewModel()
    
}


struct VehicleTypeDataProviderEnvironment: EnvironmentKey {
    static let defaultValue: VehicleTypeDataProvider = VehicleTypeDataProvider()
}

extension EnvironmentValues {
    var vehicleTypeDataProvider: VehicleTypeDataProvider {
        get { self[VehicleTypeDataProviderEnvironment.self] }
        set { self[VehicleTypeDataProviderEnvironment.self] = newValue }
    }
}

@main
struct Eco_Harbour_SwiftUIApp: App {
    
    @StateObject private var userData = UserData()
    @StateObject private var distanceViewModel = DistanceViewModel()
    @StateObject var vehicleTypeDataProviderEnv = VehicleTypeDataProvider()
    @StateObject var emissionDataViewModelWrapper = EmissionDataViewModelWrapper()
    
    init(){
            FirebaseApp.configure()
            print("Firebase configured")
        }

    var body: some Scene {
        WindowGroup {
//            RootView()
            //let emissionDataViewModelWrapper = EmissionDataViewModelWrapper()
//            RecordView2(showSignInView: .constant(false))
            SplashScreen()
                .environmentObject(userData)
                .environmentObject(distanceViewModel)
                .environmentObject(vehicleTypeDataProviderEnv)
                .environmentObject(emissionDataViewModelWrapper)
        }
    }
}
