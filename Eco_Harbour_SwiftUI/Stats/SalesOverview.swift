/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Sales Overview definitions.
*/

import Charts
import SwiftUI

struct SalesOverviewChart: View {
    var body: some View {
        Chart(SalesData.last30Days, id: \.day) {
            BarMark(
                x: .value("Day", $0.day, unit: .day),
                y: .value("Emissions", $0.sales)
            )
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

struct SalesOverview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Emissions")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(SalesData.last30DaysTotal, format: .number) Carbon Emissions")
                .font(.title2.bold())

            SalesOverviewChart()
                .frame(height: 100)
        }
    }
}

#Preview {
    SalesOverview()
        .padding()
}
