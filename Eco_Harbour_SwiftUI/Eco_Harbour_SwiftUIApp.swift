//
//  Eco_Harbour_SwiftUIApp.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 15/01/24.
//

import SwiftUI
struct EmissionDataViewModel: EmissionDataProvider {
    let last14DaysData: [(Date, Int)] = [
        (Date().addingTimeInterval(-13 * 24 * 60 * 60), 1200),
        (Date().addingTimeInterval(-12 * 24 * 60 * 60), 970),
        (Date().addingTimeInterval(-11 * 24 * 60 * 60), 850),
        (Date().addingTimeInterval(-10 * 24 * 60 * 60), 1100),
        (Date().addingTimeInterval(-9 * 24 * 60 * 60), 1020),
        (Date().addingTimeInterval(-8 * 24 * 60 * 60), 940),
        (Date().addingTimeInterval(-7 * 24 * 60 * 60), 1120),
        (Date().addingTimeInterval(-6 * 24 * 60 * 60), 1250),
        (Date().addingTimeInterval(-5 * 24 * 60 * 60), 970),
        (Date().addingTimeInterval(-4 * 24 * 60 * 60), 850),
        (Date().addingTimeInterval(-3 * 24 * 60 * 60), 400),
        (Date().addingTimeInterval(-2 * 24 * 60 * 60), 1020),
        (Date().addingTimeInterval(-1 * 24 * 60 * 60), 940),
        (Date(), 112)
    ]
    
    var last14DaysTotal: Int {
        // Calculate total emissions for the last 14 days
        return last14DaysData.map { $0.1 }.reduce(0, +)
    }
}

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

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(userData)
                .environmentObject(distanceViewModel)
                .environmentObject(vehicleTypeDataProviderEnv)
                .environmentObject(emissionDataViewModelWrapper)
        }
    }
}
