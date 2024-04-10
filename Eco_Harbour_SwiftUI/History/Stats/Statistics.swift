import SwiftUI

struct Statistics: View {
    var body: some View {
        VStack {
            HStack {
                Text("Statistics")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.bottom, 20)
            
            
            List {
                Section() {
                    VStack{
                        EmissionStatisticsView()
                    }
                }
                Section() {
                    VStack {
                        VehicleStatisticsView()
                    }
                }
            }.background(.white)
            
            .scrollContentBackground(.hidden)        }
    }
}


struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
