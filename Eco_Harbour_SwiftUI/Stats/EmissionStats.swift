import SwiftUI
import Charts
import GameplayKit

// MARK: - Data Model

// Define the TimeRange enum
private enum TimeRange {
    case last14Days
    //case last30Days
    //case last12Months
}

// Define the EmissionDataProvider protocol
protocol EmissionDataProvider {
    var last14DaysData: [(Date, Int)] { get }
    var last14DaysTotal: Int { get }
}

// MARK: - Views

struct EmissionOverviewChart: View {
    var data: [(Date, Int)]

    var body: some View {
        Chart(data, id: \.0) {
            BarMark(
                x: .value("Day", $0.0, unit: .day),
                y: .value("Emissions", $0.1)
            )
        }
        .chartScrollableAxes(.horizontal)
        .chartXAxis {
            AxisMarks(values: data.map { $0.0 }) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .chartYAxis(.visible)
    }
}

struct EmissionsStatsOverview: View {
    var dataProvider: EmissionDataProvider

    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Carbon Emissions")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(dataProvider.last14DaysTotal, format: .number) Carbon Emissions")
                .font(.title2.bold())

            EmissionOverviewChart(data: dataProvider.last14DaysData)
                .frame(height: 150)
        }
    }
}

struct EmissionsStatsDetails: View {
    var dataProvider: EmissionDataProvider
    @State private var timeRange: TimeRange = .last14Days
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Total Carbon Emissions")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                switch timeRange {
                case .last14Days:
                    Text("\(dataProvider.last14DaysTotal, format: .number) Carbon Emissions")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    
                    EmissionOverviewChart(data: dataProvider.last14DaysData)
                        .frame(height: 150)
                }
            }
            .listRowSeparator(.visible)
            .transaction {
                $0.animation = nil // Do not animate between different sets of bars.
            }
        }
    }
}
