// EmissionHistoryView.swift

import SwiftUI
import Charts

struct EmissionHistoryView: View {
    // Sample data for top emissions bar chart
    private enum Destinations {
        case empty
        case emissions
        case vehicleType
        case locations
        case salesMinMaxAverage
        case background
    }
    
    @State private var selection: Destinations?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    NavigationLink(value: Destinations.emissions) {
                        EmissionsStatsOverview()
                    }
                }
                Section {
                    NavigationLink(value: Destinations.vehicleType) {
                        VehicleTypeOverview()
                    }
                }
                Section {
                    NavigationLink(value: Destinations.locations) {
                        LocationOverview()
                    }
                }
                
//                Section("Additional examples") {
//                    NavigationLink("Daily Average, Min, Max", value: Destinations.salesMinMaxAverage)
//                    NavigationLink("Plot Area Styling", value: Destinations.background)
//                }
            }
            .navigationBarBackButtonHidden(true)
#if !os(macOS)
            .listStyle(.insetGrouped)
#endif
        } detail: {
            NavigationStack {
                switch selection ?? .empty {
                case .empty: Text("Select data to view.")
                case .emissions: EmissionsStatsView()
                case .vehicleType: VehicleTypeStatsView()
                case .locations: LocationDetails()
                case .salesMinMaxAverage: SalesMinMaxAverage()
                case .background: ChartWithBackground()
                }
            }
        }
    }
    
    
    struct EmissionHistoryView_Previews: PreviewProvider {
        static var previews: some View {
            EmissionHistoryView()
        }
    }
}
