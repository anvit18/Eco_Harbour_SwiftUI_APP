//import SwiftUI
//import Charts
//// MARK: - Chart Views
//
//struct CarbonEmissionOverviewChart: View {
//    let symbolSize: CGFloat = 100
//    let lineWidth: CGFloat = 3
//
//    var body: some View {
//        let chartContent = Chart {
//            ForEach(CarbonEmissionData.last30Days) { series in
//                ForEach(series.emissions, id: \.day) { element in
//                    LineMark(
//                        x: .value("Day", element.day, unit: .day),
//                        y: .value("Emissions", element.emissions)
//                    )
//                    .foregroundStyle(by: .value("Vehicle Type", series.city))
//                    .symbol(by: .value("Vehicle Type", series.city))
//                }
//            }
//            PointMark(
//                x: .value("Day", CarbonEmissionData.last30DaysBest.weekday, unit: .day),
//                y: .value("Emissions", CarbonEmissionData.last30DaysBest.emissions)
//            )
//            .foregroundStyle(.purple)
//            .symbolSize(symbolSize)
//        }
//        
//        return chartContent
//            .interpolationMethod(.catmullRom)
//            .lineStyle(StrokeStyle(lineWidth: lineWidth))
//            .symbolSize(symbolSize)
//            .chartForegroundStyleScale([
//                "Car": .red,
//                "Train": .blue,
//                "Bus": .purple,
//                "Auto": .green
//            ])
//            .chartSymbolScale([
//                "Car": Square().strokeBorder(lineWidth: lineWidth),
//                "Bus": Circle().strokeBorder(lineWidth: lineWidth),
//                "Auto": Square().strokeBorder(lineWidth: lineWidth),
//                "Train": Circle().strokeBorder(lineWidth: lineWidth)
//            ])
//            .chartXAxis {
//                AxisMarks(values: .stride(by: .day)) { _ in
//                    AxisTick()
//                    AxisGridLine()
//                    AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
//                }
//            }
//            .chartYAxis(.hidden)
//            .chartYScale(range: .plotDimension(end: 60))
//            .padding()
//    }
//
//}
//
//// MARK: - Placeholder Data
//
//struct CarbonEmissionData {
//    struct Series {
//        let city: String
//        let emissions: [(day: Date, emissions: Int)]
//    }
//    
//    static let last30Days: [Series] = [
//        Series(city: "Chennai", emissions: [
//            (day: Date().addingTimeInterval(-86400 * 29), emissions: 30),
//            (day: Date().addingTimeInterval(-86400 * 28), emissions: 40),
//            // Add more data points as needed
//        ]),
//        // Add more series for different cities
//    ]
//    
//    static let last12Months: [Series] = [
//        Series(city: "Chennai", emissions: [
//            (day: Date().addingTimeInterval(-86400 * 365), emissions: 300),
//            (day: Date().addingTimeInterval(-86400 * 364), emissions: 400),
//            // Add more data points as needed
//        ]),
//        // Add more series for different cities
//    ]
//
//    static let last30DaysBest: (city: String, weekday: Date, emissions: Int) = ("Chennai", Date(), 50)
//    static let last12MonthsBest: (city: String, weekday: Date, emissions: Int) = ("Chennai", Date(), 500)
//}
//
//// MARK: - Preview
//
//struct DayWiseStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarbonEmissionOverview()
//    }
//}
//
//struct DayWiseStats_Previews: PreviewProvider {
//    static var previews: some View {
//        DayWiseStats()
//    }
//}
