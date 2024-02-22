import SwiftUI

struct historyVIEW_demo: View {
    let selectedCategory: String
    let selectedDate: Date
    let carType: String
    let carTime: String
    let busType: String
    let busTime: String
    let trainType: String
    let trainTime: String
    let carPoolType: String
    let carPoolTime: String
    let autoType: String
    let autoTime: String
    let dummyVar: String
    let fuel: String
    let numberOfPassengers: String

    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 20)

                Spacer()
            }
            .padding(.bottom, 20)

            // Display your historical data using the provided arguments
            // You can customize this part based on your requirements
            Text("Selected Category: \(selectedCategory)")
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
            Text("Car Type: \(carType)")
            Text("Car Time: \(carTime)")
            // ... (Add similar lines for other arguments)

            // Add more views or modify as needed for displaying historical data
        }
        .navigationTitle("History")
    }

    // DateFormatter for formatting the date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
