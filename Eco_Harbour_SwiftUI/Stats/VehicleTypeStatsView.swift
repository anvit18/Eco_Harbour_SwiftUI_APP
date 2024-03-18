import SwiftUI

struct VehicleTypeStatsView: View {
    var body: some View {
        TabView {
            VehicleTypeOverview()
                .tabItem {
                    Label("Overview", systemImage: "chart.bar.xaxis")
                }

            VehicleTypeDetails()
                .tabItem {
                    Label("Details", systemImage: "list.bullet.rectangle")
                }
        }
        .padding()
    }
}

struct VehicleTypeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleTypeStatsView()
    }
}
