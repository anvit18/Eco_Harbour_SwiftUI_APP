import SwiftUI

struct Record: Identifiable {
    let id = UUID()
    var selectedCategory: String
    var selectedDate: Date
    var carType: String
    var carTime: String
    var busType: String
    var busTime: String
    var trainType: String
    var trainTime: String
    var carPoolType: String
    var carPoolTime: String
    var autoType: String
    var autoTime: String
    var dummyVar: String
    var fuel: String
    var numberOfPassengers: String
}

struct historyView: View {
    let records: [Record]

    @State private var selectedDate = Date()

    init(selectedCategory: String,
         selectedDate: Date,
         carType: String,
         carTime: String,
         busType: String,
         busTime: String,
         trainType: String,
         trainTime: String,
         carPoolType: String,
         carPoolTime: String,
         autoType: String,
         autoTime: String,
         dummyVar: String,
         fuel: String,
         numberOfPassengers: String) {

        // You can customize this to add conditions for when to include certain records
        var filteredRecords: [Record] = []

        // Add Car record if it has data
        if !carType.isEmpty || !carTime.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Car", selectedDate: selectedDate, carType: carType, carTime: carTime, busType: "", busTime: "", trainType: "", trainTime: "", carPoolType: "", carPoolTime: "", autoType: "", autoTime: "", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Bus record if it has data
        if !busType.isEmpty || !busTime.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Bus", selectedDate: selectedDate, carType: "", carTime: "", busType: busType, busTime: busTime, trainType: "", trainTime: "", carPoolType: "", carPoolTime: "", autoType: "", autoTime: "", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Train record if it has data
        if !trainType.isEmpty || !trainTime.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Train", selectedDate: selectedDate, carType: "", carTime: "", busType: "", busTime: "", trainType: trainType, trainTime: trainTime, carPoolType: "", carPoolTime: "", autoType: "", autoTime: "", dummyVar: "", fuel: "", numberOfPassengers: ""))
        }

        // Add Car Pool record if it has data
        if !carPoolType.isEmpty || !carPoolTime.isEmpty || !numberOfPassengers.isEmpty || !fuel.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Car Pool", selectedDate: selectedDate, carType: "", carTime: "", busType: "", busTime: "", trainType: "", trainTime: "", carPoolType: carPoolType, carPoolTime: carPoolTime, autoType: "", autoTime: "", dummyVar: "", fuel: fuel, numberOfPassengers: numberOfPassengers))
        }

        // Add Auto record if it has data
        if !autoType.isEmpty || !autoTime.isEmpty {
            filteredRecords.append(Record(selectedCategory: "Auto", selectedDate: selectedDate, carType: "", carTime: "", busType: "", busTime: "", trainType: "", trainTime: "", carPoolType: "", carPoolTime: "", autoType: autoType, autoTime: autoTime, dummyVar: "", fuel: "", numberOfPassengers: ""))
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

            if !record.carTime.isEmpty {
                Text("Car Time: \(record.carTime)")
                    .foregroundColor(.secondary)
            }

            if record.selectedCategory == "Car Pool" {
                if !record.carPoolType.isEmpty {
                    Text("Car Pool Type: \(record.carPoolType)")
                        .foregroundColor(.secondary)
                }

                if !record.carPoolTime.isEmpty {
                    Text("Car Pool Time: \(record.carPoolTime)")
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

            if !record.busTime.isEmpty {
                Text("Bus Time: \(record.busTime)")
                    .foregroundColor(.secondary)
            }

            if !record.autoType.isEmpty {
                Text("Auto Type: \(record.autoType)")
                    .foregroundColor(.secondary)
            }

            if !record.autoTime.isEmpty {
                Text("Auto Time: \(record.autoTime)")
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

                if !record.carTime.isEmpty {
                    DetailRow(title: "Car Time", value: record.carTime)
                }

                if record.selectedCategory == "Car Pool" {
                    if !record.carPoolType.isEmpty {
                        DetailRow(title: "Car Pool Type", value: record.carPoolType)
                    }

                    if !record.carPoolTime.isEmpty {
                        DetailRow(title: "Car Pool Time", value: record.carPoolTime)
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

                if !record.busTime.isEmpty {
                    DetailRow(title: "Bus Time", value: record.busTime)
                }

                if !record.trainType.isEmpty {
                    DetailRow(title: "Train Type", value: record.trainType)
                }

                if !record.trainTime.isEmpty {
                    DetailRow(title: "Train Time", value: record.trainTime)
                }

                if !record.autoType.isEmpty {
                    DetailRow(title: "Auto Type", value: record.autoType)
                }

                if !record.autoTime.isEmpty {
                    DetailRow(title: "Auto Time", value: record.autoTime)
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
            carTime: "1 hr",
            busType: "",
            busTime: "",
            trainType: "",
            trainTime: "",
            carPoolType: "",
            carPoolTime: "",
            autoType: "",
            autoTime: "",
            dummyVar: "",
            fuel: "",
            numberOfPassengers: ""
        )
    }
}
