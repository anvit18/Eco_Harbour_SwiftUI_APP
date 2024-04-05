import SwiftUI

struct Statistics: View {
    var body: some View {
        VStack {
            HStack{
                Text("Statistics")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            
            List {
                Section() {
                    VStack{
                        EmissionStatisticsView()
                    }
                }
                Section(header: Text("Vehicle Type Stats")) {
                    VStack {
                        VehicleStatisticsView()
                    }
                }
            }/*.background(.white)*/
//                .scrollContentBackground(.hidden)
        }
    }
}


struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
