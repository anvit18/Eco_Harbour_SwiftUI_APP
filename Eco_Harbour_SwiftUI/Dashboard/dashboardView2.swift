import SwiftUI
import Charts




struct CarbonEmissionByVehicle2: Identifiable {
    var id = UUID().uuidString
    var vehicleType: String
    var emissions: Int
    var color: Color
}

struct MacroData2 {
    let name : String
    let value: Int
}

struct Bar2: Identifiable {
    let id = UUID()
    var name: String
    var day: String
    var value: Double
    var color: Color
    
    // Sample data for bars
    static var sampleBars2: [Bar] {
        var tempBars = [Bar]()
        var color: Color = .green
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        
        for i in 1...7 {
            let rand = Double.random(in: 20...200.0)
            
            // Set color based on the random value
            if rand > 625 {
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

struct dashboardView2: View {
    
    //IMPORTANT BACKEND STUFF
    @StateObject private var viewModel=DashboardViewModel()
    @Binding var showSignInView:Bool    
    @StateObject private var historyViewModel=AppHistoryModel()
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MMM-YY"
        return dateFormatter.string(from: date)
    }
    
    
    
    
    
    
    
    
    
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
    
    private var macros: [MacroData2] {
        if let data = viewModel.data{
            return
            [
                .init(name: "You", value:Int(data.userEmission)),
                .init(name: "National Avg", value:625)
            ]}
        return []
        }
        
    // Chart data
    //    var emissionsData = [
    //        CarbonEmissionByVehicle(vehicleType: "Pvt. Car", emissions: 380, color: .red),
    //        CarbonEmissionByVehicle(vehicleType: "Cab", emissions: 300, color: .indigo),
    //        CarbonEmissionByVehicle(vehicleType: "Auto", emissions: 180, color: .orange),
    //        CarbonEmissionByVehicle(vehicleType: "Local Train", emissions: 100, color: .purple),
    //        CarbonEmissionByVehicle(vehicleType: "AC Bus", emissions: 400, color: .cyan),
    //    ]
    
    
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
            CarbonEmissionByVehicle2(vehicleType: "Car", emissions: carEmission+car_PoolEmission, color: .blue),
            CarbonEmissionByVehicle2(vehicleType: "Auto", emissions: autoEmission, color: .green),
            CarbonEmissionByVehicle2(vehicleType: "Bus", emissions: busEmission, color: .orange),
            CarbonEmissionByVehicle2(vehicleType: "Train", emissions: trainEmission, color: .purple),
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
                
                List {
                    if let historyData = historyViewModel.historyData {
                        // Filter documents to include only those on or before today's date
                        let currentDate = Date()
                        let filteredDocuments = historyData.documents.filter { $0.key <= formattedDate(currentDate) }
                        
                        // Get the document with the latest date among the filtered documents
                        if let closestDocument = filteredDocuments.max(by: { $0.key < $1.key }) {
                            VStack(alignment: .leading) {
                                Text("Document ID: \(closestDocument.key)")
                                    .font(.headline)
                                
                                ForEach(closestDocument.value.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                    Text("\(key): \(String(describing: value))")
                                        .font(.subheadline)
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                
                
                
                
                
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
                                    if let data = viewModel.data{
                                        Text("\(Int(data.userEmission)) kg").foregroundColor(.black)
                                        Text("CO").foregroundStyle(Color.green)
                                        Text("2").foregroundStyle(Color.green)
                                            .baselineOffset(-10)
                                    }
                                    
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
                            
                            
                            if let data = viewModel.data{
                                Text("Your emissions are \(String(format: "%.1f", Double(data.userEmission)/Double(nationalAverageEmission)))x the national average. You need to lower down!")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                            }
                            
                        }
                        .padding()
                        
                        
                        if(showSignInView==false){
                            HStack(alignment: .bottom) {
                                
                                if let historyData = historyViewModel.historyData {
                                    ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                                        VStack(alignment: .leading) {
                                            
                                            
                                            // Iterate through the documentData to find the user_emissions value
                                            if let userEmissions = documentData["user_emissions"] as? Double {
                                                // Use userEmissions to create the bar view
                                                VStack {
                                                    ZStack {
                                                        Rectangle()
                                                            .foregroundColor(.red) // Get color based on user emissions
                                                            .frame(width: 35, height: CGFloat(userEmissions)/10, alignment: .bottom)
                                                            .opacity(selectedID == UUID(uuidString: documentID) ? 0.5 : 1.0) // Adjust opacity based on selection
                                                            .cornerRadius(6)
                                                            .onTapGesture {
                                                                self.selectedID = UUID(uuidString: documentID) ?? UUID() // Update selectedID
                                                                self.text = "Value: \(Int(userEmissions))" // Update text
                                                            }
                                                        
                                                        Text("\(Int(userEmissions))")
                                                            .foregroundColor(.white)
                                                    }
//                                                    Text("Day: \(documentData["selected_date"] ?? "")") // Assuming you have a "day" field in documentData
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                }

//                                if let historyData = viewModel.historyData {
//                                    ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
//                                        VStack(alignment: .leading) {
//                                            Text("Date: \(documentID)")
//                                                .font(.headline)
//                                            
//                                            
//                                            ForEach(documentData.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
//                                                Text("\(key): \(String(describing: value))")
//                                                    .font(.subheadline)
//                                            }
//                                            
//                                        }
//                                        .padding()
//                                    }
//                                }
                                
//                                ForEach(bars) { bar in
//                                    VStack {
//                                        ZStack {
//                                            Rectangle()
//                                                .foregroundColor(bar.color)
//                                                .frame(width: 35, height: CGFloat(bar.value), alignment: .bottom)
//                                                .opacity(selectedID == bar.id ? 0.5 : 1.0)
//                                                .cornerRadius(6)
//                                                .onTapGesture {
//                                                    self.selectedID = bar.id
//                                                    self.text = "Value: \(Int(bar.value))"
//                                                }
//                                            
//                                            Text("\(Int(bar.value))")
//                                                .foregroundColor(.white)
//                                        }
//                                        Text(bar.day)
//                                    }
//                                }
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
        //IMPORTANT BACKEND STUFF
        .task{
            try? await viewModel.loadCurrentUser()
            try? await historyViewModel.loadCurrentUser()
        }
    }
    
    struct dashboardView2_Previews: PreviewProvider {
        static var previews: some View {
            dashboardView2(showSignInView: .constant(false), privateDistance: 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                .environmentObject(UserData())
                .environmentObject(DistanceViewModel())
        }
    }
}