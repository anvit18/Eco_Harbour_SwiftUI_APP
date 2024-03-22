import SwiftUI
import Charts




struct VehicleTypeDetails: View {
    @EnvironmentObject var vehicleTypeDataProviderEnv: VehicleTypeDataProvider
    @EnvironmentObject var distanceViewModel: DistanceViewModel

    var privateCarEmissions: Int {
        return distanceViewModel.privateVDistance * 20
    }
    var cabEmissions: Int {
        return distanceViewModel.cabsVDistance * 18
    }
    var carPoolEmissions: Int {
        return distanceViewModel.carpoolVDistance * 16
    }
    var localTrainEmissions: Int {
        return distanceViewModel.localTrainVDistance * 4
    }
    var metroEmissions: Int {
        return distanceViewModel.metroVDistance * 8
    }
    var pillionEmissions: Int {
        return distanceViewModel.pillionVDistance * 13
    }
    var sharingEmissions: Int {
        return distanceViewModel.sharingVDistance * 7
    }
    var magicEmissions: Int {
        return distanceViewModel.magicVDistance * 9
    }
    var ordinaryEmissions: Int {
        return distanceViewModel.ordinaryVDistance * 3
    }
    var deluxeEmissions: Int {
        return distanceViewModel.deluxeVDistance * 5
    }
    var acEmissions: Int {
        return distanceViewModel.acVDistance * 10
    }

    var data: [(name: String, emissions: Int)] {
        [
            (name: "Car", emissions: privateCarEmissions + cabEmissions + carPoolEmissions),
            (name: "Auto", emissions: pillionEmissions + sharingEmissions + magicEmissions),
            (name: "Bus", emissions: ordinaryEmissions + acEmissions + deluxeEmissions),
            (name: "Train", emissions: localTrainEmissions + metroEmissions)
        ]
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Vehicle-wise Emissions till today")
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.leading, 20)

            List {
                VStack(alignment: .leading) {
                    VehicleTypeDetailsChart(
                        data: data,
                        mostEmitted: mostEmitted
                    )
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }

    var mostEmitted: (name: String, emissions: Int) {
        guard let maxEmission = data.max(by: { $0.emissions < $1.emissions }) else {
            return (name: "Unknown", emissions: 0)
        }
        return maxEmission
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
            .opacity(element.name == (selectedType?.name ?? mostEmitted.name) ? 1 : 0.3) // Adjusted opacity here
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


#if DEBUG
struct VehicleTypeDetails_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleTypeDataProviderEnv = VehicleTypeDataProvider()
        return VehicleTypeDetails()
            .environmentObject(vehicleTypeDataProviderEnv)
            .environmentObject(DistanceViewModel())
    }
}
#endif
