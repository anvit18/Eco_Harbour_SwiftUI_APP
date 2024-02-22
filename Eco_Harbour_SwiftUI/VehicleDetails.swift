import SwiftUI

struct VehicleDetails: View {
    let selectedVehicles: Set<String>
    @State private var selectedTime = Date()
    @State private var showingNextScreen = false

    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State private var showStepper = false
    
    
//  TBD
    @State private var privateHours: Int = 0
    @State private var privateMinutes: Int = 0
    @State private var showPrivateStepper = false

    @State private var cabsHours: Int = 0
    @State private var cabsMinutes: Int = 0
    @State private var showCabsStepper = false

    @State private var carpoolHours: Int = 0
    @State private var carpoolMinutes: Int = 0
    @State private var showCarpoolStepper = false

    @State private var localTrainHours: Int = 0
    @State private var localTrainMinutes: Int = 0
    @State private var showLocalTrainStepper = false

    @State private var metroHours: Int = 0
    @State private var metroMinutes: Int = 0
    @State private var showMetroStepper = false

    @State private var pillionHours: Int = 0
    @State private var pillionMinutes: Int = 0
    @State private var showPillionStepper = false

    @State private var sharingHours: Int = 0
    @State private var sharingMinutes: Int = 0
    @State private var showSharingStepper = false

    @State private var magicHours: Int = 0
    @State private var magicMinutes: Int = 0
    @State private var showMagicStepper = false

    @State private var ordinaryHours: Int = 0
    @State private var ordinaryMinutes: Int = 0
    @State private var showOrdinaryStepper = false

    @State private var acHours: Int = 0
    @State private var acMinutes: Int = 0
    @State private var showACStepper = false

    @State private var deluxeHours: Int = 0
    @State private var deluxeMinutes: Int = 0
    @State private var showDeluxeStepper = false

    
    
    

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()

            VStack {

                Form {
                    
                    
                    if selectedVehicles.contains(where: { $0 == "Private" || $0 == "Cabs" || $0 == "Carpool" }) {
                        Section(header: Text("Cars")) {
                            ForEach(selectedVehicles.filter { $0 == "Private" || $0 == "Cabs" || $0 == "Carpool" }, id: \.self) { vehicle in
                                

                                
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(vehicle)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .onTapGesture {
                                                    showStepper.toggle()
                                                }
                                            Text("Time Travelled")
                                            Spacer()
                                        }
                                        if showStepper {
                                            VStack {
                                                Stepper(value: $hours, in: 0...24) {
                                                    Text("Hours: \(hours)")
                                                }
                                                .padding(.horizontal)
                                                Stepper(value: $minutes, in: 0...55, step: 5) {
                                                    Text("Minutes: \(minutes)")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }}
                            }
                        }
                    }

                    if selectedVehicles.contains(where: { $0 == "Ordinary" || $0 == "AC" || $0 == "Deluxe" }) {
                        Section(header: Text("Bus")) {
                            ForEach(selectedVehicles.filter { $0 == "Ordinary" || $0 == "AC" || $0 == "Deluxe" }, id: \.self) { vehicle in
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(vehicle)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .onTapGesture {
                                                    showStepper.toggle()
                                                }
                                            Text("Time Travelled")
                                            Spacer()
                                        }
                                        if showStepper {
                                            VStack {
                                                Stepper(value: $hours, in: 0...24) {
                                                    Text("Hours: \(hours)")
                                                }
                                                .padding(.horizontal)
                                                Stepper(value: $minutes, in: 0...55, step: 5) {
                                                    Text("Minutes: \(minutes)")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }}
                            }
                        }
                    }

                    if selectedVehicles.contains(where: { $0 == "Local Train" || $0 == "Metro" }) {
                        Section(header: Text("Train")) {
                            ForEach(selectedVehicles.filter { $0 == "Local Train" || $0 == "Metro" }, id: \.self) { vehicle in
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(vehicle)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .onTapGesture {
                                                    showStepper.toggle()
                                                }
                                            Text("Time Travelled")
                                            Spacer()
                                        }
                                        if showStepper {
                                            VStack {
                                                Stepper(value: $hours, in: 0...24) {
                                                    Text("Hours: \(hours)")
                                                }
                                                .padding(.horizontal)
                                                Stepper(value: $minutes, in: 0...55, step: 5) {
                                                    Text("Minutes: \(minutes)")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }}
                            }
                        }
                    }

                    if selectedVehicles.contains(where: { $0 == "Pillion" || $0 == "Sharing" || $0 == "Magic" }) {
                        Section(header: Text("Auto")) {
                            ForEach(selectedVehicles.filter { $0 == "Pillion" || $0 == "Sharing" || $0 == "Magic" }, id: \.self) { vehicle in
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(vehicle)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                                .onTapGesture {
                                                    showStepper.toggle()
                                                }
                                            Text("Time Travelled")
                                            Spacer()
                                        }
                                        if showStepper {
                                            VStack {
                                                Stepper(value: $hours, in: 0...24) {
                                                    Text("Hours: \(hours)")
                                                }
                                                .padding(.horizontal)
                                                Stepper(value: $minutes, in: 0...55, step: 5) {
                                                    Text("Minutes: \(minutes)")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }}
                            }
                        }
                    }
                }

                Button("Next") {
                    //authenticate user
                    showingNextScreen.toggle()

                }
                .foregroundColor(.white)
                .frame(width:201, height:44)
                .background(Color.green)
                .cornerRadius(10)

                NavigationLink(destination: homePageDashboard(), isActive: $showingNextScreen){
                                    EmptyView()
                                }

            }.navigationTitle("Vehicle Details")
                .navigationBarTitle("Details")
        }
    }
}

struct VehicleDetails_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetails(selectedVehicles: ["Private", "Cabs", "Carpool","AC"])
    }
}
