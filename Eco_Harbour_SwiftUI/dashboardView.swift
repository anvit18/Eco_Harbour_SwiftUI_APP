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
                .foregroundColor(.white)
        }
    }
}

struct dashboardView: View {
    @State private var macros: [MacroData] = [
        .init(name: "You", value:1360),
        .init(name: "National Avg", value:625)
    ]
    // Chart data
    var emissionsData = [
        CarbonEmissionByVehicle(vehicleType: "Pvt. Car", emissions: 250, color: .red),
        CarbonEmissionByVehicle(vehicleType: "Cab", emissions: 300, color: .indigo),
        CarbonEmissionByVehicle(vehicleType: "Auto", emissions: 180, color: .orange),
        CarbonEmissionByVehicle(vehicleType: "Local Train", emissions: 100, color: .purple),
        CarbonEmissionByVehicle(vehicleType: "AC Bus", emissions: 400, color: .cyan),
    ]
    
    // User and national average emissions
    let nationalAverageEmission = 625
    let userEmissions = 1360
    
    // Bars data
    @State private var bars = Bar.sampleBars
    @State private var selectedID: UUID = UUID()
    
    // Additional state variables
    @State private var showingNextScreen = false
    @State private var userName = "Anvit"
    @State private var text = "Info"
    
    var body: some View {
        ZStack {
            VStack {
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
                    .padding(.bottom, -35)
                    
                    // User's carbon footprint breakdown chart
                    Image("transport_vector")
                        .resizable()
                        .frame(width: 240, height: 140)
                    
                    Text("Your average monthly carbon footprint is")
                        .font(.subheadline)
                    
                    VStack {
                        ZStack {
                            // Chart showing emissions breakdown
                            Chart {
                                ForEach(emissionsData) { data in
                                    SectorMark(angle: .value("Emissions", data.emissions), innerRadius: .ratio(0.66), angularInset: 1.5)
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
                            .frame(height: 350)
                            .chartXAxis(.hidden)
                            
                            VStack {
                                Text("Carbon Emissions")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("Daily breakdown")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                                
                                HStack(spacing: 0) {
                                    Text("\(userEmissions) ")
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
                                .fontWeight(.semibold)
                                .padding(.top, 20)
                        
                            Chart(macros, id:\.name){
                                macro in BarMark(x: .value("Macros", macro.value), stacking: .normalized  )
                                    .foregroundStyle(by:.value("Name", macro.name))
                            }
                            .frame(height:48)
                            .chartXAxis(.hidden)
                            
                            Text("Your emissions are \(userEmissions/nationalAverageEmission)x the national average. You need to lower down!")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        }
                        .padding()
                        
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
                        Button("Refresh")  {
                            withAnimation {
                                self.bars = Bar.sampleBars
                            }
                        }
                        .padding()
                        
                        Button("Log Data + ") {
                            // Authenticate user
                            showingNextScreen.toggle()
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 201, height: 44)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.top, 20)
                        
                        NavigationLink(destination: recordView(), isActive: $showingNextScreen) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 50)
                
                // Bar chart for additional data
               
            }
        }
    }
}

struct dashboardView_Previews: PreviewProvider {
    static var previews: some View {
        dashboardView()
    }
}
