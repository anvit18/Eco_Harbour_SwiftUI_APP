import SwiftUI

struct manualFilling: View {
    @State private var vehicleType = ""
    @State private var fuelType = ""
    @State private var fuelConsumption = ""
    @State private var vehicleAge = ""
    @State private var showingNextScreen = false

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Eco")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                Text("Harbour")
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            
            HStack{
                Text("Vehicle Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 50)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -2)
            Menu {
                Button("Cancel", role: .destructive) {
                }
                Button {
                    vehicleType = "Small"
                }label: {
                    Label("Small (1-3)", systemImage:  "car.side.fill")
                }
                Button {
                    vehicleType = "Medium"
                } label: {
                    Label("Medium (3-5)", systemImage: "suv.side.fill")
                }
                Button {
                    vehicleType = "Large"
                } label: {
                    Label("Large (5+)", systemImage: "truck.pickup.side.fill")
                }
            } label: {
                TextField("e.g. Large" , text: $vehicleType){
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
            .padding(.top, 30)

            NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
                EmptyView()
            }
            .navigationBarTitle("Manual Entry Details")
        }
    }
}

struct manualFilling_Previews: PreviewProvider {
    static var previews: some View {
        manualFilling()
    }
}
