import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    Text("History")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top)
                        .padding(.leading)

                    ScrollView {
                        // Display the date picked at the top left corner
                        if userData.datePicked != nil {
                            Text("Date: \(formattedDate(userData.datePicked!))")
                                .padding(.leading)
                                .foregroundColor(.black)
                        }

                        // Display vehicle distance data in a tabular form
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(vehicleData.filter { $0.1 != 0 }, id: \.0) { (vehicleType, distance) in
                                HStack {
                                    Text(vehicleType)
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    Spacer()

                                    Text("Distance: \(distance) km")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                // Check if it's the user's first visit to the page
                if !userData.hasVisitedHistoryView {
                    userData.hasVisitedHistoryView = true
                    // Present the login view directly
                    NavigationLink(
                        destination: Login_Signup_Page(),
                        isActive: $userData.hasVisitedHistoryView
                    ) {
                        EmptyView()
                    }
                }
            }
            //.navigationBarTitle("History")
        }
    }

    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    // Define the data for vehicles
    private var vehicleData: [(String, Int)] {
        [
            ("Private Car", distanceViewModel.privateVDistance),
            ("Cab", distanceViewModel.cabsVDistance),
            ("Car Pool", distanceViewModel.carpoolVDistance),
            ("Local Train", distanceViewModel.localTrainVDistance),
            ("Metro", distanceViewModel.metroVDistance),
            ("Pillion Auto", distanceViewModel.pillionVDistance),
            ("Sharing Auto", distanceViewModel.sharingVDistance),
            ("Magic Auto", distanceViewModel.magicVDistance),
            ("Ordinary Bus", distanceViewModel.ordinaryVDistance),
            ("AC Bus", distanceViewModel.acVDistance),
            ("Deluxe Bus", distanceViewModel.deluxeVDistance)
        ]
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())
    }
}
