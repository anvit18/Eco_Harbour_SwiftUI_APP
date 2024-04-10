import SwiftUI
import Charts




struct CarbonEmissionByVehicle2: Identifiable {
    var id = UUID().uuidString
    var vehicleType: String
    var emissions: Int
    var color: Color
}

struct MacroData2 : Identifiable{
    let id: UUID
    let name : String
    let value: Int
}

struct Bar2: Identifiable {
    let id = UUID()
    var name: String
    var day: String
    var value: Double
    var color: Color
    

}

struct BarView2: View {
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

struct BarMarkData {
    let id = UUID() // Add an identifier
    let category: String // X-axis category
    let value: Int // Y-axis value
}

struct dashboardView2: View {
    
    //IMPORTANT BACKEND STUFF
    @StateObject private var viewModel=DashboardViewModel()
    @Binding var showSignInView:Bool
    @StateObject private var historyViewModel=AppHistoryModel()
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MMM EEE"
        return dateFormatter.string(from: date)
    }
    
    
    
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
 
    
    private var macros: [MacroData2] {
        if let data = viewModel.data {
            return [
                MacroData2(id: UUID(), name: "You", value: Int(data.userEmission)),
                MacroData2(id: UUID(), name: "National Avg(2023)", value: 625)
            ]
        }
        return []
    }


    
    @State private var emissionsData: [CarbonEmissionByVehicle2] = []
    
    func updateEmissionsData() {
        
        var carEmission=0
        var car_PoolEmission=0
        var autoEmission=0
        var busEmission=0
        var trainEmission=0
        
        if let data = viewModel.data{
            carEmission=data.carDistance*1
            car_PoolEmission=data.carpoolDistance*2
            autoEmission=data.autoDistance*3
            busEmission=data.busDistance*4
            trainEmission=data.trainDistance*5
        }
        
        emissionsData = [
            CarbonEmissionByVehicle2(vehicleType: "Car", emissions: carEmission+car_PoolEmission, color: .mainGreen),
            CarbonEmissionByVehicle2(vehicleType: "Auto", emissions: autoEmission, color: .mainGreen.opacity(0.7)),
            CarbonEmissionByVehicle2(vehicleType: "Bus", emissions: busEmission, color: .green.opacity(0.4)),
            CarbonEmissionByVehicle2(vehicleType: "Train", emissions: trainEmission, color: .green)
            //CarbonEmissionByVehicle(vehicleType: "", emissions: acBusEmissions, color: .cyan),
        ]
    }
    
    
    
    
    // User and national average emissions
    let nationalAverageEmission = 625
    let currentDate = Date()
        let dateFormatter = DateFormatter()
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
                        Text("Hi, Vishal")
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
                        
                        NavigationLink(destination: AppHistory()) {
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
                        }}
                        
                        
                        // Stat: National Average vs User Emissions
                        VStack {
                            ZStack{
                                VStack {
                                
                                    Chart(macros) { macro in
                                        
                                      
                                        BarMark(
                                            x: .value("Category", macro.name),
                                            y: .value("Value", macro.value)
                                        )
                                        .foregroundStyle(.green.opacity(0.8))
                                        .annotation(position: .top) {
                                            Text("\(macro.value)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .padding(4)
                                                .background(Color.white)
                                                .cornerRadius(4)
                                                .padding(4)
                                        }
                                    }
                                    .frame(width:280, height: 160)
                                    
                                    
                                    
                                    
                                    
                                    
                                    if let data = viewModel.data {
                                        let userEmissionRatio = Double(data.userEmission) / Double(nationalAverageEmission)
                                        HStack{
                                            Text("You emitted")
                                            Text("\(String(format: "%.1f", userEmissionRatio))x").font(.title2).bold().foregroundColor(.mainGreen)
                                            Text("the national average today!")
                                            
                                        }.font(.caption)
                                            .foregroundColor(.black)
                                            .padding(.top, 10)
                                    }
                                }
                            }
                        }
                        .padding(.vertical,20)
                        
                        
                        
                        
                        if(showSignInView==false){
                            //List {
                            //    Section(header: Text("Glance")) {
                            VStack {
                                HStack{
                                    Text("Weekly Analysis")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding(.leading,20)
                                    //.fontWeight(.semibold)
                                        .padding(.top, 20)
                                    Spacer()
                                }
                                .padding(.bottom,-5)
                                
                                
                                if let historyData = historyViewModel.historyData {
                                    ZStack{
                                        Rectangle()
                                            .fill(Color.white) // Set the fill to clear to make the shadow visible
                                            .cornerRadius(20)
                                            .frame(width: 350, height: 230)
                                            .padding(10)
                                            .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
                                        
                                        HStack{
                                            // Define custom colors for each vehicle type
                                            let customColors: [String: Color] = [
                                                "Car": .mainGreen,
                                                "Auto": .mainGreen.opacity(0.7),
                                                "Bus": .green.opacity(0.4),
                                                "Train": .green
                                                // Add more colors for other vehicle types if needed
                                            ]
                                            
                                            Chart {
                                                ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                                                    if let carDistance = documentData["car_distance"] as? Double,
                                                       let carPoolDistance = documentData["car_pool_distance"] as? Double,
                                                       let trainDistance = documentData["train_distance"] as? Double,
                                                       let busDistance = documentData["bus_distance"] as? Double,
                                                       let autoDistance = documentData["auto_distance"] as? Double {
                                                        
                                                        BarMark(
                                                            x: .value("Document \(documentID)", documentID),
                                                            y: .value("Car Distance", carDistance), width: .fixed(22.0)
                                                        )
                                                        .foregroundStyle(customColors["Car", default: .green])
                                                        
                                                        
                                                        BarMark(
                                                            x: .value("Document \(documentID)", documentID),
                                                            y: .value("Train Distance", trainDistance), width: .fixed(22.0)
                                                        )
                                                        .foregroundStyle(customColors["Train", default: .purple])
                                                        
                                                        BarMark(
                                                            x: .value("Document \(documentID)", documentID),
                                                            y: .value("Bus Distance", busDistance), width: .fixed(22.0)
                                                        )
                                                        .foregroundStyle(customColors["Bus", default: .orange])
                                                        
                                                        BarMark(
                                                            x: .value("Document \(documentID)", documentID),
                                                            y: .value("Auto Distance", autoDistance), width: .fixed(22.0)
                                                        )
                                                        .foregroundStyle(customColors["Auto", default: .green])
                                                    }
                                                }
                                            }
                                            .chartScrollableAxes(.horizontal)
                                            .frame(width: 260, height: 180)
                                            .padding(.leading, 10)
                                            
                                            
                                            
                                            
                                            //Spacer()
                                            ZStack {
                                                Rectangle()
                                                    .fill(Color.gray.opacity(0.09))
                                                    .cornerRadius(8)
                                                    .frame(width:80, height:230)
                                                    .padding(10)
                                                    .shadow(color: Color.black.opacity(0.8), radius: 20, x: 2, y: 7)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    ForEach(emissionsData) { data in
                                                        HStack {
                                                            Circle()
                                                                .fill(data.color)
                                                                .frame(width: 13, height: 13) // Make it square
                                                            Text(data.vehicleType)
                                                                .font(.callout)
                                                        }
                                                    }
                                                    .padding(.horizontal)
                                                    .foregroundColor(.black)
                                                }
                                            }.padding(.leading,-10)
                                        }
                                        
                                    }
                                        //.BarWidth(0.5)
                                    } else {
                                        ProgressView()
                                    }
                                    
                            }
                            
//
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
                        //
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
            
            //IMPORTANT BACKEND STUFF
            .task{
                try? await viewModel.loadCurrentUser()
                try? await historyViewModel.loadCurrentUser()
            }
        }
    }
    }
    
    struct dashboardView2_Previews: PreviewProvider {
        static var previews: some View {
            dashboardView2(showSignInView: .constant(false), privateDistance: 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                .environmentObject(UserData())
                .environmentObject(DistanceViewModel())
        }
    }
