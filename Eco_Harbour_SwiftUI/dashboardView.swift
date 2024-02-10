//
//  dashboardView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 17/01/24.
//

import SwiftUI
import Charts

struct CarbonEmissionByVehicle: Identifiable {
    var id = UUID().uuidString
    var vehicleType: String
    var emissions: Int
    var color :Color
}

struct dashboardView: View {
    
    var emissionsData = [
        CarbonEmissionByVehicle(vehicleType: "Pvt. Car", emissions: 250, color: .red),
        CarbonEmissionByVehicle(vehicleType: "Cab", emissions: 300, color: .indigo),
        CarbonEmissionByVehicle(vehicleType: "Auto", emissions: 180, color: .orange),
        CarbonEmissionByVehicle(vehicleType: "Local Train", emissions: 100, color: .purple),
        CarbonEmissionByVehicle(vehicleType: "AC Bus", emissions: 400, color: .cyan),
    ]
    
   
    @State private var userEmissions = "1360"+" kg"
    @State private var showingNextScreen = false
    @State private var userName  = "Anvit"
    var body: some View {
        ZStack {
            //Color.mainGreen.opacity(0.1).ignoresSafeArea()
            
            VStack {
                ScrollView {
                    HStack {
                        Text("Greetings, \(userName) !")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        
                        Spacer()
                         
                    }.padding(.bottom, -35)
                    
                    Image("transport_vector").resizable()
                        .frame(width: 300, height: 180)
                    
                    Text("Your average monthly carbon footprint is")
                        .font(.subheadline)
                    
                    
                    
                    VStack {
                        ZStack {
                            Chart {
                                ForEach(emissionsData) { data in
                                    SectorMark(angle: .value("Emissions", data.emissions), innerRadius: .ratio(0.66), angularInset: 1.5)
                                        .cornerRadius(9)
                                        .foregroundStyle(data.color)
                                        .annotation(position: .overlay){
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
                                
                                HStack(spacing: 0)
                                {
                                    Text("\(userEmissions) ")
                                    Text("CO").foregroundStyle(Color.green)
                                    Text("2").foregroundStyle(Color.green)
                                        .baselineOffset(-10)
                                    
                                }.font(.title)
                                    .bold()
                                    .frame(width: 300, height: 50)
                            }
                        }
                        //Spacer()
                        
                        
                        
                        Button("Log Data + ") {
                            //authenticate user
                            showingNextScreen.toggle()
                            
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width:201, height:44)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.top, 20)
                        
                        NavigationLink(destination: recordView(), isActive: $showingNextScreen){
                            EmptyView()
                        }
                        
                    }
                    .padding()
                    
                }
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    dashboardView()
}
