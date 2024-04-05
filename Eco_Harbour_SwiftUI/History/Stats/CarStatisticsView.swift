//
//  CarStatisticsView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 05/04/24.
//

import SwiftUI
import Charts

struct CarStatisticsView: View {
    @StateObject private var historyViewModel = AppHistoryModel()
    
    
    
    
    var body: some View {
        VStack{
            if let historyData = historyViewModel.historyData {
                Chart {
                    ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                        if let userEmissions = documentData["car_distance"] as? Double {
                            BarMark(
                                x: .value("Document \(documentID)", documentID), // Adjust the label as needed
                                y: .value("Car Emissions", userEmissions*1),
                                width: .fixed(14.0)
                            )
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 1),
                                    Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 0.3)
                                ]),
                                               startPoint: .top,
                                               endPoint: .bottom)
                            )
                        }
                    }
                }
                .chartYAxis(.visible)
                .chartXAxis(.visible)
                .frame(maxWidth: .infinity)
            }
            else {
                ProgressView()
            }
            
        }.frame(height: 150)
            .task {
                try? await historyViewModel.loadCurrentUser()
            }
    }
}

#Preview {
    CarStatisticsView()
}
