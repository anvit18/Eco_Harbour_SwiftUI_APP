import SwiftUI

struct EmissionsStatsView: View {
    var body: some View {
        TabView {
//            EmissionsStatsOverview()
//                .tabItem {
//                    Label("Overview", systemImage: "chart.bar.xaxis")
//                }

            EmissionsStatsDetails()
                .tabItem {
                    Label("Details", systemImage: "list.bullet.rectangle")
                }
        }
        .padding()
    }
}

struct EmissionsStatsView_Previews: PreviewProvider {
    static var previews: some View {
        EmissionsStatsView()
    }
}
