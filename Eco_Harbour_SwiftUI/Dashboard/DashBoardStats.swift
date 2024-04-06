import SwiftUI
import Charts

struct DashBoardStats: View {
    @State private var emissionsData: [CarbonEmissionByVehicle2] = []
    @StateObject private var viewModel=DashboardViewModel()
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    
    var body: some View {
        List {
            Section(header: Text("Today's View")) {
                // Content for Today's View section
                
                    
                    HStack {
                        VStack {
                            VStack {
                                Text("Day Breakdown")
                                    .font(.callout)
                                    .foregroundStyle(.gray)
                                
                                HStack(spacing: 0) {
                                    if let data = viewModel.data {
                                        Text("\(Int(data.userEmission)) KG").foregroundColor(.black).bold()
                                        Text("CO").foregroundStyle(Color.green)
                                        Text("2").foregroundStyle(Color.green)
                                            .baselineOffset(-10)
                                    }
                                }
                                .font(.title2)
                                
                                //.padding(.bottom, 20)
                            }
                            .padding(.leading,-10)
                            
                            HStack {
                                ForEach(emissionsData.prefix(2)) { data in
                                    HStack {
                                        Spacer()
                                        Circle()
                                            .fill(data.color)
                                            .frame(width: 13, height: 13)
                                        //Spacer()
                                        VStack{
                                            Text(data.vehicleType)
                                                .font(.callout)
                                            //.bold()
                                            Text("\(data.emissions) kg")
                                                .font(.footnote)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    //.padding(.vertical, 5)
                                }
                            }
                            // .font(.footnote)
                            .padding(.leading,-20)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                            
                            HStack {
                                ForEach(emissionsData.dropFirst(2)) { data in
                                    HStack {
                                        Spacer()
                                        Circle()
                                            .fill(data.color)
                                            .frame(width: 13, height: 13)
                                        VStack{
                                            Text(data.vehicleType)
                                                .font(.callout)
                                            //.bold()
                                            Text("\(data.emissions) kg")
                                                .font(.footnote)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    //.padding(.vertical, 5)
                                }
                            }
                            // .font(.footnote)
                            .padding(.horizontal)
                            .padding(.leading,-10)
                            .foregroundColor(.black)
                        }
                        
                        
                        Chart {
                            ForEach(emissionsData) { data in
                                SectorMark(angle: .value("Emissions", data.emissions))
                                    .cornerRadius(2)
                                    .foregroundStyle(data.color)
                                    .annotation(position: .overlay) {
                                        Text("\(data.emissions) ").bold()
                                            .foregroundStyle(.white)
                                    }
                                //.foregroundStyle(by: .value("Vehicle", data.vehicleType))
                            }
                        }
                        // .chartLegend(position: .bottom, spacing: 20) // Remove this line to hide the legend
                        .foregroundColor(.black)
                        .scaledToFit()
                        .frame(width: 180, height: 150)
                        .padding(.trailing,20)
                        .padding(.leading,-15)
                        .onAppear {
                            // Use the userEmission here or any additional setup when the view appears
                            print("User Emission on Appear: \(userData.userEmission)")
                            print("check: \(distanceViewModel.privateVDistance) \(distanceViewModel.cabsVDistance) \(distanceViewModel.localTrainVDistance)")
                        }
                        
                    }
                
            }
            
            Section(header: Text("Comparison with National Average")) {
                // Content for Comparison with National Average section
            }
            
            Section(header: Text("Weekly Analysis")) {
                // Content for Weekly Analysis section
            }
        }
    }
}

#if DEBUG
struct DashBoardStats_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardStats()
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())

    }
}
#endif
