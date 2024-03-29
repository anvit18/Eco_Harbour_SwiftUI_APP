import SwiftUI

struct manualFilling: View {
    @State private var vehicleType = ""
    @State private var fuelType = ""
    @State private var fuelConsumption = ""
    @State private var vehicleAge = ""
    @State private var showingNextScreen = false
    
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
                
                ScrollView{
                    Spacer()
                    HStack{
                        Text("Vehicle Type :")
                            .foregroundStyle(Color.mainGreen)
                            .padding(.leading, 50)
                            .font(.subheadline)
                        Spacer()
                    }.padding(.bottom, -2)
                        .padding(.top,50)
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
        }
    }
}

struct manualFilling_Previews: PreviewProvider {
    static var previews: some View {
        manualFilling()
    }
}
