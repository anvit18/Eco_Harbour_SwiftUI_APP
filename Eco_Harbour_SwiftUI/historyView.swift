import SwiftUI

struct Record : Identifiable {
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
        NavigationView {
            List {
                ForEach(sampleData) { record in
                    NavigationLink(destination: RecordDetailsView(record: record)) {
                        HistoryRow(record: record)
                    }
                }
            }
            .navigationTitle("History")
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
        VStack {
            Text("Record Details")
                .font(.title)
                .padding()

            Text("Date: \(formattedDate(for: record.date))")
                .padding()

            Text("Category: \(record.category)")
                .padding()

            Text("Vehicle Type: \(record.vehicleType)")
                .padding()

            Text("Time Travelled: \(record.timeTravelled)")
                .padding()

            Text("AC Switch: \(record.isACSwitchOn ? "On" : "Off")")
                .padding()

            if let numberOfPassengers = record.numberOfPassengers {
                Text("Number of Passengers: \(numberOfPassengers)")
                    .padding()
            }

            if let fuelType = record.fuelType {
                Text("Fuel Type: \(fuelType)")
                    .padding()
            }

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

struct historyView_Previews: PreviewProvider {
    static var previews: some View {
        historyView()
    }
}
