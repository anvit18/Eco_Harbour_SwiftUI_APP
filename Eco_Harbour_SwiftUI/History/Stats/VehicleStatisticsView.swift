

import SwiftUI
import Charts

struct VehicleStatisticsView: View {
    @StateObject private var viewModel=StatisticsViewModel()
    @State private var selectedEmissions: Int?
    
    struct Emissions: Identifiable {
        var id = UUID()
        var type:String
        var emissions:Int
    }
    
    @State private var emissionData: [Emissions] = []
    
    func updateData(){
        var carEmissionOverall=0
        var car_PoolEmissionOverall=0
        var autoEmissionOverall=0
        var busEmissionOverall=0
        var trainEmissionOverall=0
        
        if let data = viewModel.data{
            carEmissionOverall=data.carDistanceOverall*1
            car_PoolEmissionOverall=data.carpoolDistanceOverall*2
            autoEmissionOverall=data.autoDistanceOverall*3
            busEmissionOverall=data.busDistanceOverall*4
            trainEmissionOverall=data.trainDistanceOverall*5
        }
        
        emissionData=[
            Emissions(type: "Car", emissions: carEmissionOverall+car_PoolEmissionOverall),
            Emissions(type: "Auto", emissions: autoEmissionOverall),
            Emissions(type: "Bus", emissions: busEmissionOverall),
            Emissions(type: "Train", emissions: trainEmissionOverall),
        ]
    }
    
    
    
    
    
    
    var body: some View{
        VStack{
            VStack{
                Chart(emissionData, id: \.type) { emission in
                    SectorMark(
                        angle: .value("Emissions", Double(emission.emissions)),
                        outerRadius: .ratio(0.9)
                    )
                    .foregroundStyle(by: .value("Type", emission.type))
                    
                }
                .chartForegroundStyleScale(domain: .automatic, range: [.red, .green, .blue, .yellow])
                .frame(height: 300)
                
//                Text("hi")
//                ForEach(emissionData, id: \.type) { emission in
//                    VStack {
//                        Text("Type: \(emission.type)")
//                        Text("Emissions: \(emission.emissions)")
//                    }
//                    .padding()
//                }
            }.onAppear {
                updateData()
            }
            
        }.task{
            try? await viewModel.loadCurrentUser()
        }
        
        
        
    }
}





struct ToyShape: Identifiable {
    var id = UUID()
    var type: String
    var emissions: Double
}

#Preview {
    VehicleStatisticsView()
}
