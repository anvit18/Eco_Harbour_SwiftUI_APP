import SwiftUI

struct OverviewView: View {
    @EnvironmentObject var emissionDataViewModelWrapper: EmissionDataViewModelWrapper
    @ObservedObject var vehicleTypeDataProviderEnv: VehicleTypeDataProvider

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Emission Data")) {
                    NavigationLink(destination: EmissionsStatsDetails(dataProvider: emissionDataViewModelWrapper.emissionDataViewModel)) {
                        EmissionsStatsOverview(dataProvider: emissionDataViewModelWrapper.emissionDataViewModel)
                    }
                }
                Section(header: Text("Vehicle Type Data")) {
                    NavigationLink(destination: VehicleTypeDetails().environmentObject(vehicleTypeDataProviderEnv)) {
                        VehicleTypeDetails().frame(width: 360, height: 400)
                    }
                }
                Section(header: Text("Day Wise Stats")) {
                    NavigationLink(destination: DayWiseStats().environmentObject(vehicleTypeDataProviderEnv)) {
                        DayWiseStats().frame(width: 360, height: 400)
                    }
                }
                
            }
            .navigationTitle("Statistics Overview")
        }
    }
}

struct OverviewItem: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(10)
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleTypeDataProvider = VehicleTypeDataProvider()
        let emissionDataViewModelWrapper = EmissionDataViewModelWrapper()
        return OverviewView(vehicleTypeDataProviderEnv: vehicleTypeDataProvider)
            .environmentObject(emissionDataViewModelWrapper)
            .environmentObject(vehicleTypeDataProvider)
    }
}
