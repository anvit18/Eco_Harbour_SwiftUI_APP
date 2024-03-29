import SwiftUI

struct AppHistory: View {
    //backend stuff
    @StateObject private var viewModel = AppHistoryModel()
    let keyLabels: [String: String] = [
        "auto_distance": "Auto Distance",
        "bus_distance": "Bus Distance",
        "car_distance": "Car Distance",
        "car_pool_distance": "Car Pool Distance",
        "train_distance": "Train Distance"
    ]

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    
    @State private var totalEmissionsToday: Double = 3.8
    @State private var emissionsPerDay: Double = 3.21
    @State private var dates: [String] = ["Today", "18 Mar, 2024", "17 Mar, 2024", "16 Mar, 2024"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                List {
                    
                    if let historyData = viewModel.historyData {
                        ForEach(historyData.documents.sorted(by: { $0.key > $1.key }), id: \.key) { documentID, documentData in
                            if let userEmissions = documentData["user_emissions"] as? Double {
                                HStack{
                                    VStack(alignment: .leading) {
                                        
                                        Text("\(documentID)")
                                            .font(.headline)
                                        
                                        
                                        
                                        ForEach(documentData.filter({ keyLabels.keys.contains($0.key) }).sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                            if let label = keyLabels[key], let intValue = value as? Int, intValue > 0 {
                                                Text("\(label): \(intValue) km")
                                                    .font(.subheadline)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Text("\(Int(userEmissions)) ")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                        .bold()
                                    Text("KG CO2 ")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(.leading,-2)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .task {
                    try? await viewModel.loadCurrentUser()
                }
            }
            .navigationTitle("Your Activity")
        }
    }
}


struct AppHistory_Previews: PreviewProvider {
    static var previews: some View {
        AppHistory()
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())
    }
}

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            //.fontWeight(.bold)
            //.padding(.vertical, 8)
    }
}

