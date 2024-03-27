import SwiftUI

struct Statistics: View {
    var body: some View {
        List {
            Section(header: Text("Emission Stats")) {
               
                   VStack{
                       EmissionStatisticsView()
                   }
                
            }
            Section(header: Text("Vehicle Type Stats")) {
                VStack {
                    VehicleStatisticsView()
                }
            }
        }.navigationBarTitle("Statistics")
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
