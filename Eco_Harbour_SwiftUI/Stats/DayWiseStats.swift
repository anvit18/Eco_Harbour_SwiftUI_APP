//import SwiftUI
//
//
//// MARK: - Main Views
//
//struct CarbonEmissionDetailsChart: View {
//    let data: [CarbonEmissionData.Series]
//    @Environment(\.calendar) var calendar
//    @Binding var rawSelectedDate: Date?
//    @Binding var rawSelectedRange: ClosedRange<Date>?
//    @Environment(\.colorScheme) var colorScheme
//    
//    var body: some View {
//        // Placeholder implementation
//        Text("CarbonEmissionDetailsChart")
//    }
//}
//
//struct CarbonEmissionDetails: View {
//    @State private var timeRange: TimeRange = .last30Days
//    @State var rawSelectedDate: Date? = nil
//    @State var rawSelectedRange: ClosedRange<Date>? = nil
//
//    var bestSales: (city: String, weekday: Date, emissions: Int) {
//        switch timeRange {
//        case .last30Days:
//            return CarbonEmissionData.last30DaysBest
//        case .last12Months:
//            return CarbonEmissionData.last12MonthsBest
//        }
//    }
//
//    var data: [CarbonEmissionData.Series] {
//        switch timeRange {
//        case .last30Days:
//            return CarbonEmissionData.last30Days
//        case .last12Months:
//            return CarbonEmissionData.last12Months
//        }
//    }
//
//    var descriptionText: Text {
//        let emissions = bestSales.emissions.formatted(.number)
//        let weekday = bestSales.weekday.formatted(.dateTime.weekday(.wide))
//        let city = bestSales.city
//        let time: String
//        switch timeRange {
//        case .last30Days:
//            time = "30 days"
//        case .last12Months:
//            time = "12 months"
//        }
//        return Text("On average, \(emissions) KG CO2 was emitted on \(weekday)s in \(city) in the past \(time).")
//    }
//
//    var title: some View {
//        VStack(alignment: .leading) {
//            Text("Day + Vehicle Type With Most Emissions")
//                .font(preTitleFont)
//                .foregroundStyle(.secondary)
//            Text("Sundays in Chennai")
//                .font(titleFont)
//        }
//    }
//
//    var body: some View {
//        List {
//            VStack(alignment: .leading) {
//                TimeRangePicker(value: $timeRange)
//                    .padding(.bottom)
//                
//                VStack(alignment: .leading, spacing: 1) {
//                    title
//                    HStack {
//                        HStack(spacing: 5) {
//                            legendSquare
//                            Text("Car")
//                                .font(labelFont)
//                                .foregroundStyle(.secondary)
//                        }
//                        
//                        HStack(spacing: 5) {
//                            legendCircle
//                            Text("Auto")
//                                .font(labelFont)
//                                .foregroundStyle(.secondary)
//                        }
//                        
//                        
//                        HStack(spacing: 5) {
//                            legendCircle
//                            Text("Train")
//                                .font(labelFont)
//                                .foregroundStyle(.secondary)
//                        }
//                        
//                        HStack(spacing: 5) {
//                            legendCircle
//                            Text("Bus")
//                                .font(labelFont)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                }
//                .opacity(rawSelectedDate == nil && rawSelectedRange == nil ? 1.0 : 0.0)
//
//                #if os(macOS)
//                Spacer(minLength: 16)
//                #else
//                Spacer(minLength: 6)
//                #endif
//                CarbonEmissionDetailsChart(
//                    data: data,
//                    rawSelectedDate: $rawSelectedDate,
//                    rawSelectedRange: $rawSelectedRange
//                )
//                #if !os(macOS)
//                .frame(height: 240)
//                #else
//                .frame(height: 500)
//                #endif
//
//                Spacer(minLength: 15)
//                descriptionText
//                    .font(descriptionFont)
//            }
//            .listRowSeparator(.hidden)
//
//            #if !os(macOS)
//            Section("Options") {
//                TransactionsLink()
//            }
//            #endif
//        }
//        .listStyle(.plain)
//        #if !os(macOS)
//        .navigationBarTitle("Day + Emissions", displayMode: .inline)
//        #endif
//        .navigationDestination(for: [Transaction].self) { transactions in
//            TransactionsView(transactions: transactions)
//        }
//        .scrollDisabled(true)
//    }
//}
//
//struct DayWiseStats: View {
//    var body: some View {
//        TabView {
//            NavigationView {
//                CarbonEmissionOverviewChart()
//            }
//            .tabItem {
//                Label("Overview", systemImage: "chart.bar.fill")
//            }
//
//            NavigationView {
//                CarbonEmissionDetails()
//            }
//            .tabItem {
//                Label("Details", systemImage: "list.bullet")
//            }
//        }
//    }
//}
