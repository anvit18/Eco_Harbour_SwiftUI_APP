//
//  VehcileDetails_CarDetails.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/01/24.
//

import SwiftUI

struct VehcileDetails_CarDetails: View {
    @State private var car = ""
    @State private var time = ""
    @State private var setDefault = false
    @State private var dummyVar = ""
    @State private var fuel = ""
    @State private var numberOfPassengers = ""
    //var numberOfPassengers = ""
    var vehicleSize = ""
    var fuelType = ""
    var timeTravelled = ""
    var isACSwitchOn = false
    var body: some View {
        VStack(spacing: 0) {
            
            HStack{
                Text("Vehicle Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 30)
                    .padding(.bottom, 20)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -10)
            
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
                TextField("e.g. Large" , text: $car){ //fields.vehicleSize){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            
            
            
            HStack{
                Text("Time Travelled")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 30)
                    .padding(.bottom, 20)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -10)
            
            Menu {
                Button("Cancel", role: .destructive) {
                    // Do something
                }
                
                Button {
                    // do something
                    time = "30mins"
                }label: {
                    Label("30 Mins", systemImage:  "car.side.fill")
                }
                
                Button {
                    // Do something
                    time = "1hr"
                } label: {
                    Label("1 Hr", systemImage: "suv.side.fill")
                }
                
                Button {
                    // Do something
                    time = "2hr"
                } label: {
                    Label("2 Hrs", systemImage: "truck.pickup.side.fill")
                }
            } label: {
                TextField("e.g. 4" , text: $time){ //fields.vehicleSize){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            
            
            
           
                
                    
              
                //.keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                //if selectedCategory == "Car Pool" {
                
                HStack{
                    Text("Number of Passengers")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                    Spacer()
                }.padding(.bottom, -10)
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    Button {
                        // do something
                        numberOfPassengers = "1"
                    }label: {
                        Label("1", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // do something
                        numberOfPassengers = "2"
                    }label: {
                        Label("2", systemImage:  "car.side.fill")
                    }
                    
                    
                    Button {
                        // do something
                        numberOfPassengers = "3"
                    }label: {
                        Label("3", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // do something
                        numberOfPassengers = "4"
                    }label: {
                        Label("4", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        numberOfPassengers = "5"
                    } label: {
                        Label("5", systemImage: "suv.side.fill")
                    }
                    
                    Button {
                        // Do something
                        numberOfPassengers = "6"
                    } label: {
                        Label("6", systemImage: "truck.pickup.side.fill")
                    }
                } label: {
                    TextField("e.g. 4" , text: $numberOfPassengers){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                HStack{
                    Text("Fuel Type")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                    Spacer()
                }.padding(.bottom, -10)
                
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
            }.navigationBarTitle("Car Details")

        }
        
    }
    
    #Preview {
        VehcileDetails_CarDetails()
    }

