import SwiftUI
import Charts

struct AppHistory: View {
    // Backend stuff
    @StateObject private var viewModel = AppHistoryModel()
    
    let keyLabels: [String: String] = [
        "auto_distance": "Auto Distance",
        "bus_distance": "Bus Distance",
        "car_distance": "Car Distance",
        "car_pool_distance": "Car Pool Distance",
        "train_distance": "Train Distance"
    ]
    
    // Define colors for each vehicle type
    let vehicleColors: [String: Color] = [
        "Car": .mainGreen,
        "Auto": .mainGreen.opacity(0.7),
        "Bus": .green.opacity(0.7),
        "Train": .green
    ]
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    
    @State private var totalEmissionsToday: Double = 3.8
    @State private var emissionsPerDay: Double = 3.21
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack{
                    HStack {
                        Text("Your Activity")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .bold()
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    List {
                        //                        HStack {
                        //                            Text("Your Activity")
                        //                                .font(.title)
                        //                                .bold()
                        //                                .foregroundColor(.black)
                        //                                .padding(.leading, 20)
                        //
                        //                            Spacer()
                        //                        }.padding(.bottom, 15)
                        if let historyData = viewModel.historyData {
                            ForEach(historyData.documents.sorted(by: { $0.key > $1.key }), id: \.key) { documentID, documentData in
                                if let userEmissions = documentData["user_emissions"] as? Double {
                                    NavigationLink(destination: DetailView(documentData: documentData, documentID: documentID)) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text("\(documentID)")
                                                        .font(.title3)
                                                        .bold()
                                                    Text("\(Int(userEmissions)) KG CO\u{2082}")
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundColor(.green)
                                                        .bold()
                                                    Text("Carbon Emissions")
                                                        .font(.footnote)
                                                        .foregroundColor(.gray)
                                                }
                                                Spacer()
                                                VStack{
                                                    Text("Distances")
                                                        .font(.footnote)
                                                        .foregroundColor(.gray)
                                                    Chart {
                                                        ForEach(documentData.filter({ keyLabels.keys.contains($0.key) }).sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                                            let distance = value as? Double ?? 0
                                                            let label = keyLabels[key] ?? ""
                                                            let vehicleType = label.replacingOccurrences(of: " Distance", with: "")
                                                            let color = vehicleColors[vehicleType] ?? .black // Default color if not found
                                                            
                                                            SectorMark(angle: .value(label, distance), innerRadius: .ratio(0.55), angularInset: 1.3)
                                                                .cornerRadius(2)
                                                                .foregroundStyle(color)
                                                                .annotation(position: .overlay) {
                                                                    Text("\(Int(distance)) ").font(.footnote)
                                                                        .foregroundStyle(.white)
                                                                }
                                                        }
                                                    }
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .padding(.top, 10)
                                                    .padding(.bottom, 5)
                                                }
                                            }
                                        }
                                        .background(Color(.systemBackground))
                                        .cornerRadius(10)
                                        //.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                    }
                                }
                            }
                        }
                    }.background(.white)
                    
                        .scrollContentBackground(.hidden)
                        .task {
                            try? await viewModel.loadCurrentUser()
                        }
                }
            }
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
struct DetailView: View {
    let documentData: [String: Any]
    let documentID: String
    
    // Define key labels for vehicle distances
    let keyLabels: [String: String] = [
        "auto_distance": "Auto Distance",
        "bus_distance": "Bus Distance",
        "car_distance": "Car Distance",
        "car_pool_distance": "Car Pool Distance",
        "train_distance": "Train Distance"
    ]
    
    // Define colors for each vehicle type
    let vehicleColors: [String: Color] = [
        "Car": .mainGreen,
        "Auto": .mainGreen.opacity(0.7),
        "Bus": .green.opacity(0.7),
        "Train": .green
    ]
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .center) { // Align content vertically at the center
                
                
                
                VStack {
                    Text("\(documentID)")
                        .font(.headline)
                    
                    
                    Chart {
                        ForEach(documentData.filter({ keyLabels.keys.contains($0.key) }).sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            let distance = value as? Double ?? 0
                            let label = keyLabels[key] ?? ""
                            let vehicleType = label.replacingOccurrences(of: " Distance", with: "")
                            let color = vehicleColors[vehicleType] ?? .black // Default color if not found
                            
                            SectorMark(angle: .value(label, distance), innerRadius: .ratio(0.55), angularInset: 1.3)
                                .cornerRadius(2)
                                .foregroundStyle(color)
                                .annotation(position: .overlay) {
                                    Text("\(Int(distance)) ").font(.footnote)
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                    .chartLegend(position: .topTrailing, spacing: 20)
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    
                    
                    
                    ForEach(documentData.filter({ keyLabels.keys.contains($0.key) }).sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        if let label = keyLabels[key], let intValue = value as? Int, intValue > 0 {
                            ZStack {
                                HStack{
                                    Text("\(label):")
                                        .font(.subheadline)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30)
                                        .padding(.horizontal)
                                        .background(Color.clear)
                                        .border(Color.clear, width: 1) // Transparent border
                                    Text("\(intValue) km")
                                        .font(.subheadline)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30)
                                        .padding(.horizontal)
                                        .background(Color.clear)
                                        .border(Color.clear, width: 1) // Transparent border
                                }
                            }
                        }
                    }
                    
                }
                
                
            }
        }
        .padding()
    }
    
}
