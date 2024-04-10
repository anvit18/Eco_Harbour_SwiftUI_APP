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
            .init(name: "National Avg(2023)", value:625)
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
            CarbonEmissionByVehicle(vehicleType: "Car", emissions: privateCarEmissions + cabEmissions + carPoolEmissions, color: .mainGreen),
            CarbonEmissionByVehicle(vehicleType: "Auto", emissions: pillionEmissions + sharingEmissions + magicEmissions, color: .mainGreen.opacity(0.7)),
            CarbonEmissionByVehicle(vehicleType: "Bus", emissions: ordinaryEmissions + acEmissions + deluxeEmissions, color: .green.opacity(0.7)),
            CarbonEmissionByVehicle(vehicleType: "Train", emissions: localTrainEmissions + metroEmissions, color: .green),
            //CarbonEmissionByVehicle(vehicleType: "", emissions: acBusEmissions, color: .cyan),
        ]
    }
    // User and national average emissions
    let nationalAverageEmission = 625
    let dateFormatter = DateFormatter()
    let currentDate = Date()
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
    
    func dayOfWeek(date: Date) -> String {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
        
        // Function to get the month of the year
        func monthOfYear(date: Date) -> String {
            dateFormatter.dateFormat = "MMMM"
            return dateFormatter.string(from: date)
        }
        
        // Function to get the day of the month
        func dayOfMonth(date: Date) -> String {
            dateFormatter.dateFormat = "d"
            return dateFormatter.string(from: date)
        }

    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {

                    
                ScrollView {
                    // Greetings and user information
                    HStack {
                        Text("\(dayOfWeek(date: currentDate)), ")
                            .font(.title3)
                            .padding(.leading,20)
                            .textCase(.uppercase)
                        //.bold()
                        
                        Text(monthOfYear(date: currentDate))
                            .font(.title3)
                            .padding(.leading,-10)
                            .textCase(.uppercase)
                        // .bold()
                        
                        Text(dayOfMonth(date: currentDate))
                            .font(.title3)
                            .padding(.leading,-6)
                            .textCase(.uppercase)
                        //.bold()
                        
                        Spacer()
                    }.foregroundColor(.gray)
                    
                    
                    
                    // Greetings and user information
                    HStack {
                        Text("Hi, Guest")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.bottom, 15)
                    
                    VStack {
                        HStack{
                            
                            Text("Carbon Emissions")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(.top, 15)
                                .padding(.leading,20)
                            Spacer()
                        }
                        .padding(.bottom,-5)
                        
                       
                            ZStack{
                                
                                Rectangle()
                                    .fill(Color.white) // Set the fill to clear to make the shadow visible
                                    .cornerRadius(20)
                                    .frame(width: 350, height: 230)
                                    .padding(10)
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
                                
                                HStack {
                                    VStack {
                                        VStack {
                                            Text("Day Breakdown")
                                                .font(.body)
                                                .foregroundStyle(.gray)
                                            
                                            HStack(spacing: 0) {
                                               // if let data = viewModel.data {
                                                    Text("\(Int(userData.userEmission)) KG").foregroundColor(.black).bold()
                                                    Text("CO").foregroundStyle(Color.green)
                                                    Text("2").foregroundStyle(Color.green)
                                                        .baselineOffset(-10)
                                               // }
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
                                        .padding(.leading,-20)
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
                                    Text("Login for Daily Records and Statistics")
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
