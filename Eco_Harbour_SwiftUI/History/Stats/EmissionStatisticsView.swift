import SwiftUI
import Charts

struct EmissionStatisticsView: View {
    @StateObject private var historyViewModel = AppHistoryModel()
    @State private var selectedID: UUID?
    @State private var text = ""
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MMM-YY"
        return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack {
            if let historyData = historyViewModel.historyData {
                
                Chart {
                    ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                        if let userEmissions = documentData["user_emissions"] as? Double {
                            BarMark(
                                x: .value("Document \(documentID)", documentID), // Adjust the label as needed
                                y: .value("User Emissions", userEmissions)
                            )
                        }
                    }
                }
                .chartScrollableAxes(.horizontal)
                .chartYAxis(.visible)
                .chartXAxis(.visible)
                .frame(width: 300)
                //.BarWidth(0.5)
            } else {
                ProgressView()
            }
        }.frame(height: 200)
        .task {
            try? await historyViewModel.loadCurrentUser()
        }
    }
}

#Preview {
    EmissionStatisticsView()
}
