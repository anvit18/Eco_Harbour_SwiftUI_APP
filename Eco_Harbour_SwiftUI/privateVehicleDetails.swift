import SwiftUI

struct privateVehicleDetails: View {
    @State private var isShowingDialog = false
    @State private var vehicleNumber = ""
    @State private var showingNextScreen = false
    @State private var showingFillManually = false
    @State private var showingWhyWeAsk = false
    @State private var cityName = ""
    @State private var isFirstVisit = true // Add a state variable to track the first visit
    @State private var vehicleType = ""
    @State private var fuelType = ""
    @State private var fuelConsumption = ""
    @State private var vehicleAge = ""
    //@State private var showingNextScreen = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                HStack(spacing: 0) {
                    Text("Eco")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                    Text("Track")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .bold()
                }
                .padding(.bottom, 50)
                ScrollView {
                    // Your main content here
                    HStack {
                        Text("Enter City Name:")
                            .offset(x: -80)
                            .foregroundColor(.black)
                        //.background(.secondary)
                            .padding(.horizontal, 10)
                            .font(.headline)
                        //.frame(alignment: .trailing)
                    }
                    Menu {
                        Button("Cancel", role: .destructive) {
                            // Do something
                        }
                        
                        Button {
                            // do something
                            cityName = "Chennai"
                        }label: {
                            Label("Chennai", systemImage:  "")
                        }
                        
                        Button {
                            // Do something
                            cityName = "Mumbai"
                        } label: {
                            Label("Mumbai", systemImage: "")
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Button {
                            // Do something
                            cityName = "Pune"
                        } label: {
                            Label("Pune", systemImage:"")
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    } label: {
                        TextField("e.g. Chennai", text: $cityName)
                            .padding(.leading,-160)
                            .autocapitalization(.allCharacters)
                            .frame(width: 300, height: 50)
                        // .foregroundColor(.black)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                    }.padding(.bottom,20)
                    
                   
                    HStack{
                        Text("Vehicle Type :")
                            .foregroundStyle(Color.mainGreen)
                            .padding(.leading, 50)
                            .font(.subheadline)
                        Spacer()
                    }.padding(.bottom, -2)
                        //.padding(.top,50)
                    Menu {
                        Button("Cancel", role: .destructive) {
                        }
                        Button {
                            vehicleType = "Hatchback"
                        }label: {
                            Label("Hatchback", systemImage:  "car.side.fill")
                        }
                        Button {
                            vehicleType = "MUV"
                        }label: {
                            Label("MUV", systemImage:  "car.side.fill")
                        }
                        Button {
                            vehicleType = "Pickup Truck"
                        }label: {
                            Label("Pickup Truck", systemImage:  "car.side.fill")
                        }
                        Button {
                            vehicleType = "Sedan"
                        } label: {
                            Label("Sedan", systemImage: "suv.side.fill")
                        }
                        Button {
                            vehicleType = "SUV"
                        } label: {
                            Label("SUV", systemImage: "truck.pickup.side.fill")
                        }
                        Button {
                            vehicleType = "Electric"
                        } label: {
                            Label("Electric", systemImage: "truck.pickup.side.fill")
                        }
                    } label: {
                        TextField("e.g. SUV" , text: $vehicleType){
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
                        Text("Fuel Type :")
                            .foregroundStyle(Color.mainGreen)
                            .padding(.leading, 50)
                            .font(.subheadline)
                        Spacer()
                    }.padding(.bottom, -2)
                    Menu {
                        Button("Cancel", role: .destructive) {
                        }
                        Button {
                            fuelType = "Petrol"
                        }label: {
                            Label("Petrol", systemImage:  "fuelpump")
                        }
                        Button {
                            fuelType = "Diesel"
                        } label: {
                            Label("Diesel", systemImage: "fuelpump.fill")
                        }
                        Button {
                            fuelType = "Electric"
                        } label: {
                            Label("Electric", systemImage: "leaf.arrow.circlepath")
                        }
                    } label: {
                        TextField("e.g Petrol" , text: $fuelType){
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
                        Text("Daily Fuel Consumption :")
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
                        Text("Liters/100KM")
                            .padding(.trailing, 10)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
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
                    }
                    .padding()
                    Spacer()
                    
                    Button("Next") {
                        print("Car Type: \(vehicleType)")
                        print("Fuel Type: \(fuelType)")
                        print("Daily Fuel Consumption: \(fuelConsumption)")
                        print("Vehicle Age: \(vehicleAge)")
                        showingNextScreen.toggle()
                    }
                    .foregroundColor(.white)
                    .frame(width: 201, height: 44)
                    .background(Color.mainGreen)
                    .cornerRadius(10)
                    .padding(.top, 10)
                }
                NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
                    EmptyView()
                }
                .navigationBarTitle("Manual Entry Details")
            }
        }.onAppear {
            if isFirstVisit {
                isShowingDialog = true
                isFirstVisit = false
            }
        }
   // }
        // Present the dialog when isShowingDialog is true
        .alert(isPresented: $isShowingDialog) {
            Alert(
                title: Text("Let's Start Analysis!"),
                message: Text("Enter your private vehicle details for personalized testing!"),
                dismissButton: .default(Text("Close"))
            )
        }
        
        //            HStack {
        //                Text("Enter License Plate Number :")
        //                    .offset(x: -30)
        //                    .foregroundColor(.black)
        //                    .background(.white)
        //                    .padding(.horizontal, 60)
        //                    .font(.headline)
        //                    .frame(alignment: .trailing)
        //            }
        //
        //            TextField("e.g. MH 11 CG 6199", text: $vehicleNumber)
        //                .padding()
        //                .autocapitalization(.allCharacters)
        //                .frame(width: 300, height: 50)
        //                .background(Color.black.opacity(0.05))
        //                .cornerRadius(10)
        
        // HStack {
        //   Spacer()
        //                Button("Why we ask for this ?") {
        //                    //add code
        //                    showingWhyWeAsk.toggle()
        //                }
        //                .foregroundColor(.mainGreen)
        //                .underline(true, color: .mainGreen)
        //                .background(.white)
        //                .padding(.horizontal, 40)
        //                .font(.callout)
        //                .frame(alignment: .trailing)
        //                .padding(.trailing, 8)
        
        //                NavigationLink(destination: SecondView(), isActive: $showingWhyWeAsk) {
        //                    EmptyView()
        //                }
        //            }
        
        //            Text("------------ or ------------")
        //                .font(.footnote)
        //                .foregroundColor(Color.gray)
        //                .padding(.top, 20)
        //                .padding(.bottom, 30)
        
        //            Text("Not comfortable sharing License Plate number ? You can input all the details manually instead of us fetching it from your license plate number.")
        //                .foregroundColor(.black)
        //                .background(.white)
        //                .padding(.horizontal, 60)
        //                .font(.caption)
        //                .padding(.bottom, 10)
        //                .padding(.top,20)
        
//        Button("Enter Private Vehicle Details") {
//            showingFillManually.toggle()
//        }
//        
//        .foregroundColor(.blue)
//        //.bold()
//        .background(.white)
//        .underline()
//        .font(.title2)
//        .padding(.horizontal, 30)
//        .padding(.top,30)
//        .padding(.bottom,30)
//        
//        NavigationLink(destination: manualFilling(), isActive: $showingFillManually) {
//            EmptyView()
//        }
        
        //            Button("Skip") {
        //                showingNextScreen.toggle()
        //            }
        //            .foregroundColor(.white)
        //            .frame(width: 201, height: 44)
        //            .background(Color.mainGreen)
        //            .cornerRadius(10)
        //            .padding(.top, 10)
        //
        //            NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
        //                EmptyView()
        //            }
    //}
    // .navigationBarTitle("Private Vehicle Details")
    // Use .onAppear to trigger the dialog only on the first visit
}
        
            }
    //    }
    


struct privateVehicleDetails_Previews: PreviewProvider {
    static var previews: some View {
        privateVehicleDetails()
    }
}
