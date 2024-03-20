import SwiftUI

struct AppHistory: View {
    
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
                    ForEach(dates, id: \.self) { date in
                        Section(header: SectionHeaderView(title: date)) {
                            NavigationLink(destination: HistoryView(userData: _userData, distanceViewModel: _distanceViewModel)) {
                                    Text("\(String(format: "%.2f", userData.userEmission)) kg CO₂")
                                    
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(date == "Today" ? .red : .blue)
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
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
            .font(.headline)
            .fontWeight(.bold)
            //.padding(.vertical, 8)
    }
}

struct VegetarianDetailView: View {
    let score: String
    
    var body: some View {
        VStack {
            Text("Vegetarian")
                .font(.title)
                .fontWeight(.bold)
            Text("Score: \(score)")
                .font(.subheadline)
                .padding(.top, 8)
            // Add more details here as needed
        }
        .padding()
        .navigationTitle("Vegetarian Detail")
    }
}
