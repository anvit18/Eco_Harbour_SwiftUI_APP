import SwiftUI
import Charts

struct VehicleTypeData {
    /// Carbon emissions by vehicle type for the last 30 days, sorted by amount.
    static let last14Days = [
        (name: "Car", emissions: 916),
        (name: "Bus", emissions: 820),
        (name: "Auto", emissions: 610),
        (name: "Train", emissions: 350),
    ]
}

struct VehicleTypeOverviewChart: View {
    var body: some View {
        Text("Total Carbon Emissions")
            .font(.callout)
            .foregroundStyle(.secondary)
        Chart(VehicleTypeData.last14Days, id: \.name) { element in
            SectorMark(
                angle: .value("Emissions", element.emissions),
                innerRadius: .ratio(0.618),
                angularInset: 1
            )
            .cornerRadius(3.0)
            .foregroundStyle(by: .value("Name", element.name))
            .opacity(element.name == VehicleTypeData.last14Days.first!.name ? 1 : 0.3)
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
            Text(VehicleTypeData.last14Days.first!.name)
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
    
    @EnvironmentObject var vehicleTypeDataProviderEnv: VehicleTypeDataProvider

    var data: [(name: String, emissions: Int)] {
        vehicleTypeDataProviderEnv.last14DaysData
    }

    var body: some View {
        VStack(alignment: .leading){
            Text("Vehicle-wise Emissions till today")
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.leading,20)
            //.foregroundStyle(.secondary)
            List {
                VStack(alignment: .leading) {
                    VehicleTypeDetailsChart(
                        data: data,
                        mostEmitted: data.first ?? (name: "Unknown", emissions: 0)
                    )
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

#if DEBUG
struct VehicleTypeDetails_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleTypeDataProviderEnv = VehicleTypeDataProvider()
        return VehicleTypeDetails()
            .environmentObject(vehicleTypeDataProviderEnv)
    }
}
#endif
