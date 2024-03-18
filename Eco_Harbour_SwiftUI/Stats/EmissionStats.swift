import SwiftUI
import Charts
import GameplayKit

private let gaussianRandoms = GKGaussianDistribution(lowestValue: 0, highestValue: 20)





struct EmissionData {
    /// Carbon emissions by day for the last 30 days.
    static let last30Days = [
        (day: date(year: 2022, month: 5, day: 8), emissions: 125),
        (day: date(year: 2022, month: 5, day: 9), emissions: 97),
        // Add carbon emission data for the last 30 days here...
    ]

    /// Total carbon emissions for the last 30 days.
    static var last30DaysTotal: Int {
        last30Days.map { $0.emissions }.reduce(0, +)
    }

    static var last30DaysAverage: Double {
        Double(last30DaysTotal / last30Days.count)
    }

    private static func randomEmissionsForDay(_ dayNumber: Double) -> Int {
        // Generate random noise for carbon emission data.
        // You can replace this with your actual data generation logic.
        let yearlySeasonality = 50.0 * (0.5 - 0.5 * cos(2.0 * .pi * (dayNumber / 364.0)))
        let monthlySeasonality = 5.0 * (0.5 - 0.5 * cos(2.0 * .pi * (dayNumber / 30.0)))
        let weeklySeasonality = 10.0 * (1 - cos(2.0 * .pi * ((dayNumber + 2.0) / 7.0)))
        return Int(yearlySeasonality + monthlySeasonality + weeklySeasonality + Double(gaussianRandoms.nextInt()))
    }

    /// Carbon emissions by day for the last 365 days.
    static let last365Days: [(day: Date, emissions: Int)] = stride(from: 0, to: 200, by: 1).compactMap {
        let startDay: Date = date(year: 2022, month: 11, day: 17)  // 200 days before WWDC
        let day: Date = Calendar.current.date(byAdding: .day, value: $0, to: startDay)!
        let dayNumber = Double($0)
        
        var emissions = randomEmissionsForDay(dayNumber)
        let dayOfWeek = Calendar.current.component(.weekday, from: day)
        if dayOfWeek == 6 {
            emissions += gaussianRandoms.nextInt() * 3
        } else if dayOfWeek == 7 {
            emissions += gaussianRandoms.nextInt()
        } else {
            emissions = Int(Double(emissions) * Double.random(in: 4...5) / Double.random(in: 5...6))
        }
        return (
            day: day,
            emissions: emissions
        )
    }
    
    static func emissionsInPeriod(in range: ClosedRange<Date>) -> Int {
        EmissionData.last365Days.filter { range.contains($0.day) }.reduce(0) { $0 + $1.emissions }
    }
    
    /// Total carbon emissions for the last 365 days.
    static var last365DaysTotal: Int {
        last365Days.map { $0.emissions }.reduce(0, +)
    }

    static var last365DaysAverage: Double {
        Double(last365DaysTotal / last365DaysTotal)
    }

    /// Carbon emissions by month for the last 12 months.
    static let last12Months = [
        (month: date(year: 2021, month: 7), emissions: 3200, dailyAverage: 100, dailyMin: 80, dailyMax: 160),
        // Add carbon emission data for the last 12 months here...
    ]

    /// Total carbon emissions for the last 12 months.
    static var last12MonthsTotal: Int {
        last12Months.map { $0.emissions }.reduce(0, +)
    }

    static var last12MonthsDailyAverage: Int {
        last12Months.map { $0.dailyAverage }.reduce(0, +) / last12Months.count
    }
}

struct EmissionOverviewChart: View {
    var body: some View {
        Chart(EmissionData.last30Days, id: \.day) {
            BarMark(
                x: .value("Day", $0.day, unit: .day),
                y: .value("Emissions", $0.emissions)
            )
        }
        .chartXAxis(.visible)
        .chartYAxis(.visible)
    }
}

struct EmissionsStatsOverview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Carbon Emissions")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(EmissionData.last30DaysTotal, format: .number) Carbon Emissions")
                .font(.title2.bold())

            EmissionOverviewChart()
                .frame(height: 100)
        }
    }
}

struct EmissionsStatsDetails: View {
    @State private var timeRange: TimeRange = .last30Days
    @State var scrollPositionStart =
        EmissionData.last365Days.last!.day.addingTimeInterval(-1 * 3600 * 24 * 30)

    var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    var scrollPositionString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    
    var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
                                 
    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)

                Text("Total Carbon Emissions")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                switch timeRange {
                case .last30Days:
                    Text("\(EmissionData.emissionsInPeriod(in: scrollPositionStart...scrollPositionEnd), format: .number) Carbon Emissions")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    
                    Text("\(scrollPositionString) – \(scrollPositionEndString)")
                        .font(.callout)
                        .foregroundStyle(.secondary)

                    DailySalesChart(scrollPosition: $scrollPositionStart)
                        .frame(height: 240)
                case .last12Months:
                    Text("\(EmissionData.last12MonthsTotal, format: .number) Emissions")
                        .font(.title2.bold())
                        .foregroundColor(.primary)

                    MonthlySalesChart()
                        .frame(height: 240)
                }
            }
            .listRowSeparator(.visible)
            .transaction {
                $0.animation = nil // Do not animate between different sets of bars.
            }

            Section("More info") {
                // Add more info related to carbon emissions if needed...
            }
        }
        .listStyle(.plain)
        #if !os(macOS)
        .navigationBarTitle("Total Carbon Emissions", displayMode: .inline)
        #endif
    }
}

struct EmissionsStats_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmissionsStatsOverview()
                .padding()
                .previewDisplayName("Overview")

            EmissionsStatsDetails()
                .padding()
                .previewDisplayName("Details")
        }
    }
}
