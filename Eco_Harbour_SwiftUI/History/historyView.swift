import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(vehicleData, id: \.category) { vehicleCategory in
                    
                    ForEach(vehicleCategory.vehicles.filter { $0.distance > 0 }, id: \.id) { vehicle in
                        if vehicle.distance > 0 {
                            VehicleRow(vehicle: vehicle)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Vehicles Used")
        }.padding(.top,-90)
    }


    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    // Define the data for vehicles
    // Define the data for vehicles
    private var vehicleData: [VehicleCategory] {
        let allVehicleData: [VehicleCategory] = [
            VehicleCategory(category: "Car", vehicles: [
                Vehicle(name: "Private Car", distance: distanceViewModel.privateVDistance),
                Vehicle(name: "Cab", distance: distanceViewModel.cabsVDistance),
                Vehicle(name: "Car Pool", distance: distanceViewModel.carpoolVDistance)
            ]),
            VehicleCategory(category: "Public Transport", vehicles: [
                Vehicle(name: "Local Train", distance: distanceViewModel.localTrainVDistance),
                Vehicle(name: "Metro", distance: distanceViewModel.metroVDistance),
                Vehicle(name: "Ordinary Bus", distance: distanceViewModel.ordinaryVDistance),
                Vehicle(name: "AC Bus", distance: distanceViewModel.acVDistance),
                Vehicle(name: "Deluxe Bus", distance: distanceViewModel.deluxeVDistance)
            ]),
            VehicleCategory(category: "Auto", vehicles: [
                Vehicle(name: "Pillion Auto", distance: distanceViewModel.pillionVDistance),
                Vehicle(name: "Sharing Auto", distance: distanceViewModel.sharingVDistance),
                Vehicle(name: "Magic Auto", distance: distanceViewModel.magicVDistance)
            ])
        ]

        // Filter out entries whose distance is greater than 0
        let filteredVehicleData = allVehicleData.map { category in
            let filteredVehicles = category.vehicles.filter { $0.distance > 0 }
            return VehicleCategory(category: category.category, vehicles: filteredVehicles)
        }

        return filteredVehicleData
    }

}

// Define a struct for vehicle category
struct VehicleCategory: Identifiable {
    let id = UUID()
    let category: String
    let vehicles: [Vehicle]
}

// Define a struct for vehicle
struct Vehicle: Identifiable {
    let id = UUID()
    let name: String
    let distance: Int
}

// Custom row view for displaying vehicle data
struct VehicleRow: View {
    let vehicle: Vehicle
    
    var body: some View {
        HStack {
            
            Text(vehicle.name)
            Spacer()
            Text("Distance: \(vehicle.distance) km")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())
    }
}
