import SwiftUI
import Charts




struct CarbonEmissionByVehicle: Identifiable {
    var id = UUID().uuidString
    var vehicleType: String
    var emissions: Int
    var color: Color
}

struct MacroData {
    let name : String
    let value: Int
}

struct Bar: Identifiable {
    let id = UUID()
    var name: String
    var day: String
    var value: Double
    var color: Color
    
    // Sample data for bars
    static var sampleBars: [Bar] {
        var tempBars = [Bar]()
        var color: Color = .green
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        
        for i in 1...7 {
            let rand = Double.random(in: 20...200.0)
            
            // Set color based on the random value
            if rand > 150 {
                color = .red
            } else if rand > 75 {
                color = .yellow
            } else {
                color = .green
            }
            
            let bar = Bar(name: "\(i)", day: days[i-1], value: rand, color: color)
            tempBars.append(bar)
        }
        return tempBars
    }
}

struct BarView: View {
    var value: Int
    var color: Color
    var label: String

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(color)
                .frame(width: 35, height: CGFloat(value), alignment: .bottom)
                .opacity(1.0) // Opacity modified
                .cornerRadius(6)
            
            Text("\(Int(value))")
                .foregroundColor(.black)
        }
    }
}

struct dashboardView: View {
    
    //IMPORTANT BACKEND STUFF
    @StateObject private var viewModel=DashboardViewModel()
    @Binding var showSignInView:Bool
    
    
    
    
    
    
    
    
    //@State private var shouldUpdateEmissionsData = false
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    //let userEmission : Double
    
    let privateDistance: Int
    let cabsDistance: Int
    let carpoolDistance: Int
    let localTrainDistance: Int
    let metroDistance: Int
    let pillionDistance: Int
    let sharingDistance: Int
    let magicDistance: Int
    let ordinaryDistance: Int
    let acDistance: Int
    let deluxeDistance: Int
    
    let cabEmissions = 300
    //    var car: Double {
    //            // Access the privateVdistance property and calculate emissions
    //        return Double(distanceViewModel._privateVDistance.wrappedValue) * 11
    //
    //        }
    
    private var macros: [MacroData] {
        return
        [
            .init(name: "You", value:Int(userData.userEmission)),
            .init(name: "National Avg", value:625)
        ]}
    // Chart data
    //    var emissionsData = [
    //        CarbonEmissionByVehicle(vehicleType: "Pvt. Car", emissions: 380, color: .red),
    //        CarbonEmissionByVehicle(vehicleType: "Cab", emissions: 300, color: .indigo),
    //        CarbonEmissionByVehicle(vehicleType: "Auto", emissions: 180, color: .orange),
    //        CarbonEmissionByVehicle(vehicleType: "Local Train", emissions: 100, color: .purple),
    //        CarbonEmissionByVehicle(vehicleType: "AC Bus", emissions: 400, color: .cyan),
    //    ]
    
    
    @State private var emissionsData: [CarbonEmissionByVehicle] = []
    
    func updateEmissionsData() {
        let privateCarEmissions = distanceViewModel.privateVDistance * 20
        let cabEmissions = distanceViewModel.cabsVDistance * 18
        let carPoolEmissions = distanceViewModel.carpoolVDistance * 16
        let localTrainEmissions = distanceViewModel.localTrainVDistance * 4
        let metroEmissions = distanceViewModel.metroVDistance * 8
        let pillionEmissions = distanceViewModel.pillionVDistance * 13
        let sharingEmissions = distanceViewModel.sharingVDistance * 7
        let magicEmissions = distanceViewModel.magicVDistance * 9
        let ordinaryEmissions = distanceViewModel.ordinaryVDistance * 3
        let deluxeEmissions = distanceViewModel.deluxeVDistance * 5
        let acEmissions = distanceViewModel.acVDistance * 10
        
        emissionsData = [
            CarbonEmissionByVehicle(vehicleType: "Car", emissions: privateCarEmissions + cabEmissions + carPoolEmissions, color: .blue),
            CarbonEmissionByVehicle(vehicleType: "Auto", emissions: pillionEmissions + sharingEmissions + magicEmissions, color: .green),
            CarbonEmissionByVehicle(vehicleType: "Bus", emissions: ordinaryEmissions + acEmissions + deluxeEmissions, color: .orange),
            CarbonEmissionByVehicle(vehicleType: "Train", emissions: localTrainEmissions + metroEmissions, color: .purple),
            //CarbonEmissionByVehicle(vehicleType: "", emissions: acBusEmissions, color: .cyan),
        ]
    }
    // User and national average emissions
    let nationalAverageEmission = 625
    //let userEmissions = userEmission
    
    // Bars data
    @State private var bars = Bar.sampleBars
    @State private var selectedID: UUID = UUID()
    
    // Additional state variables
    @State private var showingNextScreen = false
    @State private var showingEmissionHistoryScreen = false
    @State private var userName = "Anvit"
    @State private var text = "Info"
    @State private var userLoggedIn = false
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
//                
//                List{
//                    if let user = viewModel.user{
//                        Text("UserId: \(user.userId)")
//                        
//                        if let dateCreated = user.dateCreated{
//                            Text("Date Created: \(dateCreated)")
//                        }else{
//                            Text("Date not displaying")
//                        }
//                        
//                        if let email = user.email{
//                            Text("email: \(email)")
//                        }
//                    }
//                    
//                }
//                .task{
//                    try? await viewModel.loadCurrentUser()
//                }
                
                
                    
                ScrollView {
                    // Greetings and user information
                    HStack {
                        Text("Greetings, \(userName)!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.bottom, -15)
                    
                    // User's carbon footprint breakdown chart
                    //                 Image("transport_vector")
                    //                        .resizable()
                    //                        .frame(width: 240, height: 140)
                    
                    Text("Your average daily carbon footprint is")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.top, 15)
                    
                    VStack {
                        ZStack {
                            // Chart showing emissions breakdown
                            Chart {
                                ForEach(emissionsData) { data in
                                    SectorMark(angle: .value("Emissions", data.emissions), innerRadius: .ratio(0.69), angularInset: 1.5)
                                        .cornerRadius(9)
                                        .foregroundStyle(data.color)
                                        .annotation(position: .overlay) {
                                            Text("\(data.emissions) ").bold()
                                                .foregroundStyle(.white)
                                        }
                                        .foregroundStyle(by: .value("Vehicle", data.vehicleType))
                                }
                            }
                            .chartLegend(position: .bottom, spacing: 20)
                            .foregroundColor(.black)
                            .frame(height: 350)
                            .chartXAxis(.hidden)
                            .onAppear {
                                // Use the userEmission here or any additional setup when the view appears
                                print("User Emission on Appear: \(userData.userEmission)")
                                print("check: \(distanceViewModel.privateVDistance) \(distanceViewModel.cabsVDistance) \(distanceViewModel.localTrainVDistance)")
                            }
                            
                            VStack {
                                Text("Carbon Emissions")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                
                                Text("Daily breakdown")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                                
                                HStack(spacing: 0) {
                                    Text("\(Int(userData.userEmission)) kg").foregroundColor(.black)
                                    Text("CO").foregroundStyle(Color.green)
                                    Text("2").foregroundStyle(Color.green)
                                        .baselineOffset(-10)
                                }
                                .font(.title)
                                .bold()
                                .frame(width: 300, height: 50)
                            }
                        }
                        
                        // Stat: National Average vs User Emissions
                        VStack {
                            
                            
                            Text("Comparison with National Average")
                                .font(.title2)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.top, 20)
                            
                            Chart(macros, id:\.name){
                                macro in BarMark(x: .value("Macros", macro.value), stacking: .normalized )
                                    .foregroundStyle(by:.value("Name", macro.name)
                                    )
                                    .annotation(position: .overlay) {
                                        Text("\(macro.value)").bold()
                                            .foregroundStyle(.white)
                                    }
                                    .foregroundStyle(by: .value("Emission", macro.name))
                            }
                            .frame(height:48)
                            .chartXAxis(.hidden)
                            
                            Text("Your emissions are \(Int(userData.userEmission)/nationalAverageEmission)x the national average. You need to lower down!")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        }
                        .padding()
                        
                        
                        if(showSignInView){
                            HStack(alignment: .bottom) {
                                ForEach(bars) { bar in
                                    VStack {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(bar.color)
                                                .frame(width: 35, height: CGFloat(bar.value), alignment: .bottom)
                                                .opacity(selectedID == bar.id ? 0.5 : 1.0)
                                                .cornerRadius(6)
                                                .onTapGesture {
                                                    self.selectedID = bar.id
                                                    self.text = "Value: \(Int(bar.value))"
                                                }
                                            
                                            Text("\(Int(bar.value))")
                                                .foregroundColor(.white)
                                        }
                                        Text(bar.day)
                                    }
                                }
                            }
                            .frame(height: 240, alignment: .bottom)
                            .padding(20)
                            .background(.thinMaterial)
                            .cornerRadius(6)
                            // Additional buttons and navigation
                            //                        Button("Refresh")  {
                            //                            withAnimation {
                            //                                self.bars = Bar.sampleBars
                            //                            }
                            //                        }
                            //                        .padding()
                            
                            Button("View Statistics"){
                                showingEmissionHistoryScreen.toggle()
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 351, height: 44)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.top, 20)
                            
                            
//                            NavigationLink(destination: EmissionHistoryView(), isActive: $showingEmissionHistoryScreen) {
//                                EmptyView()
//                            }
                            
                            
                            
                        }
                        else {
                            VStack {
                                HStack{
                                    Text("Login for Daily Records, Streaks, and Stats")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 20)
                                }
                                
                                
                                HStack{
                                    //change here for login_signup functionality
                                    NavigationLink{
                                        RootView()
                                    } label:{
                                        Text("Login")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 351, height: 41)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                            .padding(.bottom, 20)
                                    }
                                }
                                
                                
                            }.background(Color.red.opacity(0.1))

                        }
                        Button("Log Data + ") {
                            // Authenticate user
                            //printing all variables
                            print("Private Distance Travelled: \(privateDistance)")
                            print("Cabs Distance Travelled: \(cabsDistance)")
                            print("Carpool Distance Travelled: \(carpoolDistance)")
                            print("Local Train Distance Travelled: \(localTrainDistance)")
                            print("Metro Distance Travelled: \(metroDistance)")
                            print("Pillion Distance Travelled: \(pillionDistance)")
                            print("Sharing Distance Travelled: \(sharingDistance)")
                            print("Magic Distance Travelled: \(magicDistance)")
                            print("Ordinary Distance Travelled: \(ordinaryDistance)")
                            print("AC Distance Travelled: \(acDistance)")
                            print("Deluxe Distance Travelled: \(deluxeDistance)")
                            
                            showingNextScreen.toggle()
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 351, height: 44)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.top, 20)
                        
                        NavigationLink(destination: recordView(showSignInView: .constant(false)), isActive: $showingNextScreen) {
                            EmptyView()
                        }
                        //.padding()
                    }
                    .padding(.bottom, 50)
                    
                    // Bar chart for additional data
                    .onAppear {
                        //shouldUpdateEmissionsData.toggle()
                        updateEmissionsData()
                        // }
                    }
                }
            }
        }
    }
    
    struct dashboardView_Previews: PreviewProvider {
        static var previews: some View {
            dashboardView(showSignInView: .constant(false), privateDistance: 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                .environmentObject(UserData())
                .environmentObject(DistanceViewModel())
        }
    }
}
