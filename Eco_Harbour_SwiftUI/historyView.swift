import SwiftUI

struct Record: Identifiable {
    let id = UUID()
    var selectedCategory: String
    var selectedDate: Date
    var carType: String
    var carDistance: String  // Changed variable name
    var busType: String
    var busDistance: String  // Changed variable name
    var trainType: String
    var trainDistance: String  // Changed variable name
    var carPoolType: String
    var carPoolDistance: String  // Changed variable name
    var autoType: String
    var autoDistance: String  // Changed variable name
    var dummyVar: String
    var fuel: String
    var numberOfPassengers: String
}

struct historyView: View {
    let records: [Record]
    @State private var selectedDate = Date()
    @State private var showAlert = false  // Added state for showing the alert

    init(selectedCategory: String,
         selectedDate: Date,
         carType: String,
         carDistance: Int,  // Changed variable name
         busType: String,
         busDistance: Int,  // Changed variable name
         trainType: String,
         trainDistance: Int,  // Changed variable name
         carPoolType: String,
         carPoolDistance: Int,  // Changed variable name
         autoType: String,
         autoDistance: Int,  // Changed variable name
         dummyVar: String,
         fuel: String,
         numberOfPassengers: String) {

        // You can customize this to add conditions for when to include certain records
        var filteredRecords: [Record] = []

        // Add Car record if it has data
        // Add Car record if it has data
        if !carType.isEmpty || (carDistance != 0) {
            filteredRecords.append(Record(selectedCategory: "Car", selectedDate: selectedDate, carType: carType, carDistance: String(carDistance), busType: "", busDistance: "0", trainType: "", trainDistance: "0", carPoolType: "", carPoolDistance: "0", autoType: "", autoDistance: "0", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Bus record if it has data
        if !busType.isEmpty || (busDistance != 0) {
            filteredRecords.append(Record(selectedCategory: "Bus", selectedDate: selectedDate, carType: "", carDistance: "", busType: busType, busDistance: String(busDistance), trainType: "", trainDistance: "0", carPoolType: "", carPoolDistance: "0", autoType: "", autoDistance: "0", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Train record if it has data
        if !trainType.isEmpty || (trainDistance != 0) {
            filteredRecords.append(Record(selectedCategory: "Train", selectedDate: selectedDate, carType: "", carDistance: "", busType: "", busDistance: "", trainType: trainType, trainDistance: String(trainDistance), carPoolType: "", carPoolDistance: "0", autoType: "", autoDistance: "0", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Car Pool record if it has data
        if !carPoolType.isEmpty || (carPoolDistance != 0) || !numberOfPassengers.isEmpty || !fuel.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Car Pool", selectedDate: selectedDate, carType: "", carDistance: "", busType: "", busDistance: "", trainType: "", trainDistance: "", carPoolType: carPoolType, carPoolDistance: String(carPoolDistance), autoType: "", autoDistance: "0", dummyVar: "", fuel: fuel, numberOfPassengers: numberOfPassengers))
        }

        // Add Auto record if it has data
        if !autoType.isEmpty || (autoDistance != 0) {
            filteredRecords.append(Record(selectedCategory: "Auto", selectedDate: selectedDate, carType: "", carDistance: "", busType: "", busDistance: "", trainType: "", trainDistance: "", carPoolType: "", carPoolDistance: "", autoType: autoType, autoDistance: String(autoDistance), dummyVar: "", fuel: "", numberOfPassengers: ""))
        }


        self.records = filteredRecords
    }

    var body: some View {
        //NavigationView {
        VStack {
        //                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
        //                    .datePickerStyle(GraphicalDatePickerStyle())
        //                    .padding(.vertical, 10)

                        HStack {
                            Text("History")
                                .font(.largeTitle)
                                .bold()
                                .padding(.leading, 20)

                            Spacer()
                        }
                        .padding(.bottom, 20)

                        List {
                            ForEach(records) { record in
                                NavigationLink(destination: RecordDetailsView(record: record)) {
                                    HistoryRow(record: record)
                                }
                            }
                        }
                    }
                    //.navigationTitle("History")
                
            }
        }

struct HistoryRow: View {
    let record: Record

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date: \(formattedDate(for: record.selectedDate))")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Selected Category: \(record.selectedCategory)")
                .foregroundColor(.secondary)

            if !record.carType.isEmpty {
                Text("Car Type: \(record.carType)")
                    .foregroundColor(.secondary)
            }

            if !record.carDistance.isEmpty {
                Text("Car Distance: \(record.carDistance)")
                    .foregroundColor(.secondary)
            }

            if record.selectedCategory == "Car Pool" {
                if !record.carPoolType.isEmpty {
                    Text("Car Pool Type: \(record.carPoolType)")
                        .foregroundColor(.secondary)
                }

                if !record.carPoolDistance.isEmpty {
                    Text("Car Pool Distance: \(record.carPoolDistance)")
                        .foregroundColor(.secondary)
                }

                if let passengers = Int(record.numberOfPassengers) {
                    Text("Number of Passengers: \(passengers)")
                        .foregroundColor(.secondary)
                }

                if !record.fuel.isEmpty {
                    Text("Fuel Type: \(record.fuel)")
                        .foregroundColor(.secondary)
                }
            }

            if !record.busType.isEmpty {
                Text("Bus Type: \(record.busType)")
                    .foregroundColor(.secondary)
            }

            if !record.busDistance.isEmpty {
                Text("Bus Distance: \(record.busDistance)")
                    .foregroundColor(.secondary)
            }

            if !record.autoType.isEmpty {
                Text("Auto Type: \(record.autoType)")
                    .foregroundColor(.secondary)
            }

            if !record.autoDistance.isEmpty {
                Text("Auto Distance: \(record.autoDistance)")
                    .foregroundColor(.secondary)
            }
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

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                DetailRow(title: "Date", value: formattedDate(for: record.selectedDate))
                DetailRow(title: "Category", value: record.selectedCategory)
                DetailRow(title: "Selected Category", value: record.selectedCategory)
                DetailRow(title: "Selected Date", value: formattedDate(for: record.selectedDate))

                if !record.carType.isEmpty {
                    DetailRow(title: "Car Type", value: record.carType)
                }

                if !record.carDistance.isEmpty {
                    DetailRow(title: "Car Distance", value: record.carDistance)
                }

                if record.selectedCategory == "Car Pool" {
                    if !record.carPoolType.isEmpty {
                        DetailRow(title: "Car Pool Type", value: record.carPoolType)
                    }

                    if !record.carPoolDistance.isEmpty {
                        DetailRow(title: "Car Pool Distance", value: record.carPoolDistance)
                    }

                    if let passengers = Int(record.numberOfPassengers) {
                        DetailRow(title: "Number of Passengers", value: "\(passengers)")
                    }

                    if !record.fuel.isEmpty {
                        DetailRow(title: "Fuel Type", value: record.fuel)
                    }
                }

                if !record.busType.isEmpty {
                    DetailRow(title: "Bus Type", value: record.busType)
                }

                if !record.busDistance.isEmpty {
                    DetailRow(title: "Bus Distance", value: record.busDistance)
                }

                if !record.trainType.isEmpty {
                    DetailRow(title: "Train Type", value: record.trainType)
                }

                if !record.trainDistance.isEmpty {
                    DetailRow(title: "Train Distance", value: record.trainDistance)
                }

                if !record.autoType.isEmpty {
                    DetailRow(title: "Auto Type", value: record.autoType)
                }

                if !record.autoDistance.isEmpty {
                    DetailRow(title: "Auto Distance", value: record.autoDistance)
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

            Spacer()

            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

struct historyView_Previews: PreviewProvider {
    static var previews: some View {
        historyView(
            selectedCategory: "Car",
            selectedDate: Date(),
            carType: "Medium",
            carDistance: 0,
            busType: "",
            busDistance: 0,
            trainType: "",
            trainDistance: 0,
            carPoolType: "",
            carPoolDistance: 0,
            autoType: "",
            autoDistance: 0,
            dummyVar: "",
            fuel: "",
            numberOfPassengers: ""
        )
    }
}
