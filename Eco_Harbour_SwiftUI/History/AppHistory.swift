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
                                    
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(date == "Today" ? .red : .blue)
                                
                            }
                        }
                    }
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

