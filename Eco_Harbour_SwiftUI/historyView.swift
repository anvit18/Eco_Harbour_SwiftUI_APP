import SwiftUI

struct Record: Identifiable {
    let id = UUID()
    var date: Date
    var category: String
    var vehicleType: String
    var timeTravelled: String
    var isACSwitchOn: Bool
    var numberOfPassengers: Int?
    var fuelType: String?
}

struct historyView: View {
    let sampleData: [Record] = [
        Record(date: Date(), category: "Car", vehicleType: "Medium", timeTravelled: "1 hr", isACSwitchOn: true),
        Record(date: Date().addingTimeInterval(-86400), category: "Bus", vehicleType: "Large", timeTravelled: "2 hrs", isACSwitchOn: false),
        Record(date: Date().addingTimeInterval(-172800), category: "Car Pool", vehicleType: "Small", timeTravelled: "30 mins", isACSwitchOn: true, numberOfPassengers: 3, fuelType: "Petrol")
    ]

    var body: some View {
        // NavigationView {
        VStack {
            HStack {
                
                Text("History")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 20)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            List {
                ForEach(sampleData) { record in
                    NavigationLink(destination: RecordDetailsView(record: record)) {
                        HistoryRow(record: record)
                    }
                }
            }
           // .background(.white)
            //.navigationTitle("History")
            // }
            //.navigationViewStyle(StackNavigationViewStyle()) // Use this line if you want the navigation style to be stack.
        }
    }
}

struct HistoryRow: View {
    let record: Record

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date: \(formattedDate(for: record.date))")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Category: \(record.category)")
                .foregroundColor(.secondary)

            Text("Vehicle Type: \(record.vehicleType)")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }

    private func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct RecordDetailsView: View {
    let record: Record

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Record Details")
                .font(.title)
                //.foregroundColor(.mainGreen)

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                DetailRow(title: "Date", value: formattedDate(for: record.date))
                DetailRow(title: "Category", value: record.category)
                DetailRow(title: "Vehicle Type", value: record.vehicleType)
                DetailRow(title: "Time Travelled", value: record.timeTravelled)
                DetailRow(title: "AC Switch", value: record.isACSwitchOn ? "On" : "Off")

                if let numberOfPassengers = record.numberOfPassengers {
                    DetailRow(title: "Number of Passengers", value: "\(numberOfPassengers)")
                }

                if let fuelType = record.fuelType {
                    DetailRow(title: "Fuel Type", value: fuelType)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .navigationTitle("Details")
    }

    private func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                //.foregroundColor(.mainGreen)

            Spacer()

            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}


struct historyView_Previews: PreviewProvider {
    static var previews: some View {
        historyView()
    }
}
