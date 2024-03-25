import SwiftUI
import Charts

struct VehicleTypeData {
    /// Carbon emissions by vehicle type for the last 30 days, sorted by amount.
    static let last30Days = [
        (name: "Car", emissions: 916),
        (name: "Bus", emissions: 820),
        (name: "Auto", emissions: 610),
        (name: "Train", emissions: 350),
    ]

    /// Carbon emissions by vehicle type for the last 12 months, sorted by amount.
    static let last12Months = [
        (name: "Car", emissions: 9631),
        (name: "Bus", emissions: 6200),
        (name: "Auto", emissions: 7891),
        (name: "Train", emissions: 3300),
    ]
}

struct VehicleTypeOverviewChart: View {
    var body: some View {
        Chart(VehicleTypeData.last30Days, id: \.name) { element in
            SectorMark(
                angle: .value("Emissions", element.emissions),
                innerRadius: .ratio(0.618),
                angularInset: 1
            )
            .cornerRadius(3.0)
            .foregroundStyle(by: .value("Name", element.name))
            .opacity(element.name == VehicleTypeData.last30Days.first!.name ? 1 : 0.3)
        }
        .chartLegend(.visible)
        .chartXAxis(.visible)
        .chartYAxis(.visible)
    }
}

struct VehicleTypeOverview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Most Emissions From")
                .foregroundStyle(.secondary)
            Text(VehicleTypeData.last30Days.first!.name)
                .font(.title2.bold())
            VehicleTypeOverviewChart()
                .frame(height: 130)
        }
    }
}

struct VehicleTypeDetailsChart: View {
    let data: [(name: String, emissions: Int)]
    let mostEmitted: (name: String, emissions: Int)
    
    let cumulativeEmissionsRangesForTypes: [(name: String, range: Range<Double>)]
    
    @State var selectedEmissions: Double? = nil
    
    init(data: [(name: String, emissions: Int)], mostEmitted: (name: String, emissions: Int)) {
        self.data = data
        self.mostEmitted = mostEmitted
        
        var cumulative = 0.0
        self.cumulativeEmissionsRangesForTypes = data.map {
            let newCumulative = cumulative + Double($0.emissions)
            let result = (name: $0.name, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }
    }
    
    var selectedType: (name: String, emissions: Int)? {
        if let selectedEmissions,
           let selectedIndex = cumulativeEmissionsRangesForTypes
            .firstIndex(where: { $0.range.contains(selectedEmissions) }) {
            return data[selectedIndex]
        }
        
        return nil
    }

    var body: some View {
        Chart(data, id: \.name) { element in
            SectorMark(
                angle: .value("Emissions", element.emissions),
                innerRadius: .ratio(0.618),
                angularInset: 1.5
            )
            .cornerRadius(5.0)
            .foregroundStyle(by: .value("Name", element.name))
            .opacity(element.name == (selectedType?.name ?? mostEmitted.name) ? 1 : 0.3)
        }
        .chartLegend(alignment: .center, spacing: 18)
        .chartAngleSelection(value: $selectedEmissions)
        .scaledToFit()
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                VStack {
                    Text("Most Emissions from")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .opacity(selectedType == nil || selectedType?.name == mostEmitted.name ? 1 : 0)
                    Text(selectedType?.name ?? mostEmitted.name)
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    Text((selectedType?.emissions.formatted() ?? mostEmitted.emissions.formatted()) + " Kg CO2")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
    }
}

struct VehicleTypeDetails: View {
    @State private var timeRange: TimeRange = .last30Days

    var data: [(name: String, emissions: Int)] {
        switch timeRange {
        case .last12Months:
            return VehicleTypeData.last12Months
        case .last30Days:
            return VehicleTypeData.last12Months.map { (name, _) in
                // Keep the annual order for consistent sector ordering.
                return (
                    name: name,
                    emissions: VehicleTypeData.last30Days.first(where: { $0.name == name })?.emissions ?? 0
                )
            }
        }
    }

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)
                    .transaction {
                        $0.animation = nil // Do not animate the picker.
                    }

                VehicleTypeDetailsChart(
                    data: data,
                    mostEmitted: data.first ?? (name: "Unknown", emissions: 0)
                )
            }
            .listRowSeparator(.hidden)

            Section("Options") {
                TransactionsLink()
            }
        }
        .listStyle(.plain)
        #if !os(macOS)
        .navigationBarTitle("", displayMode: .inline)
        #endif
        .navigationDestination(for: [Transaction].self) { transactions in
            TransactionsView(transactions: transactions)
        }
    }
}

#Preview {
    VehicleTypeDetails()
}

