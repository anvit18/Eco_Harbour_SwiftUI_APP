import SwiftUI
import Charts

struct Statistics: View {

    var body: some View {
        VStack{
            EmissionStatisticsView()
        }
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
