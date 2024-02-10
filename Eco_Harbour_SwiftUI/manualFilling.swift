//
//  ContentView.swift
//  EasyMenus
//
//  Created by Federico on 11/11/2021.
//

import SwiftUI

struct manualFilling: View {
    @State private var car = ""
    @State private var fuel = ""
    @State private var fuelConsumption = ""
    @State private var carMileage = ""
    @State private var vehicleAge = ""
    @State private var showingNextScreen = false
    @State private var bs_type = ""
    var body: some View {
        VStack {
            
            HStack(spacing: 0){
                Text("Eco").font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                Text("Harbour")
                    .font(.largeTitle)
                    .bold()
                
            }//.padding(.bottom, 20)
            //start of cartype menu
            HStack{
                Text("Car Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -2)
            Menu {
                Button("Cancel", role: .destructive) {
                    // Do something
                }
                
                Button {
                    // do something
                    car = "Small"
                }label: {
                    Label("Small (1-3)", systemImage:  "car.side.fill")
                }
                
                Button {
                    // Do something
                    car = "Medium"
                } label: {
                    Label("Medium (3-5)", systemImage: "suv.side.fill")
                }
                
                Button {
                    // Do something
                    car = "Large"
                } label: {
                    Label("Large (5+)", systemImage: "truck.pickup.side.fill")
                }
            } label: {
                TextField("e.g. Large" , text: $car){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            //end of car type menu
            
            
            
            
            //start of cartype menu
            HStack{
                Text("Fuel Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -2)
            Menu {
                Button("Cancel", role: .destructive) {
                    // Do something
                }
                
                Button {
                    // do something
                    fuel = "Petrol"
                }label: {
                    Label("Petrol", systemImage:  "fuelpump")
                }
                
                Button {
                    // Do something
                    fuel = "Diesel"
                } label: {
                    Label("Diesel", systemImage: "fuelpump.fill")
                }
                
                Button {
                    // Do something
                    fuel = "Electric"
                } label: {
                    Label("Electric", systemImage: "leaf.arrow.circlepath")
                }
            } label: {
                TextField("e.g Petrol" , text: $fuel){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            //end of car type menu
            
            //car mileage
            HStack{
                Text("Car Mileage :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -20)
            
            ZStack(alignment: .trailing) {
                
                TextField("Enter Num" , text: $carMileage){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                //.padding(.bottom)
                
                Text("KMPH")
                    .padding(.trailing, 10)
                    .foregroundColor(.gray)
            }
            .padding()
            
            
            //carbon emission type
            //start of cartype menu
            HStack{
                Text("Carbon Emission Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -2)
            Menu {
                Button("Cancel", role: .destructive) {
                    // Do something
                }
                
                Button {
                    // do something
                    bs_type = "BS4"
                }label: {
                    Label("BS-IV (4)", systemImage:  "carbon.dioxide.cloud.fill")
                }
                
                Button {
                    // Do something
                    bs_type = "BS5"
                } label: {
                    Label("BS-V (5)", systemImage: "carbon.dioxide.cloud")
                }
                
                Button {
                    // Do something
                    bs_type = "BS6"
                } label: {
                    Label("BS-VI (6)", systemImage: "carbon.monoxide.cloud")
                }
            } label: {
                TextField("e.g. BS-V" , text: $bs_type){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            
            
            
            //fuel consumption
            HStack{
                Text("Monthly Fuel Consumption :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -20)
            
            ZStack(alignment: .trailing) {
                
                TextField("Enter Num" , text: $fuelConsumption){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                //.padding(.bottom)
                
                Text("Liters/100KM")
                    .padding(.trailing, 10)
                    .foregroundColor(.gray)
            }
            .padding()
            
            //vehicle age
            HStack{
                Text("Vehicle Age :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -20)
            
            ZStack(alignment: .trailing) {
                
                TextField("e.g. 4 years" , text: $vehicleAge){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                //.padding(.bottom)
                
                
                
                
            }  
            .padding()
            
            Button("Next") {
                showingNextScreen.toggle()
            }
            .foregroundColor(.white)
            .frame(width: 201, height: 44)
            .background(Color.mainGreen)
            .cornerRadius(10)
           // .padding(.top, 30)
            
            NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
                EmptyView()
            }
            
            .navigationBarTitle("Manual Entry Details")
        }
    }
    
    struct manualFilling_Previews: PreviewProvider {
        static var previews: some View {
            manualFilling()
        }
    }
}
