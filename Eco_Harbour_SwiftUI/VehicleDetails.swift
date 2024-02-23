import SwiftUI

struct VehicleDetails: View {
    let selectedVehicles: Set<String>
    @State private var selectedTime = Date()
    @State private var showingNextScreen = false
    
    // Distance variables
    @State private var privateDistance: Int = 0
    @State private var cabsDistance: Int = 0
    @State private var carpoolDistance: Int = 0
    @State private var localTrainDistance: Int = 0
    @State private var metroDistance: Int = 0
    @State private var pillionDistance: Int = 0
    @State private var sharingDistance: Int = 0
    @State private var magicDistance: Int = 0
    @State private var ordinaryDistance: Int = 0
    @State private var acDistance: Int = 0
    @State private var deluxeDistance: Int = 0
    
    @State private var showPrivateStepper = false
    @State private var showCabsStepper = false
    @State private var showCarpoolStepper = false
    @State private var showLocalTrainStepper = false
    @State private var showMetroStepper = false
    @State private var showPillionStepper = false
    @State private var showSharingStepper = false
    @State private var showMagicStepper = false
    @State private var showOrdinaryStepper = false
    @State private var showACStepper = false
    @State private var showDeluxeStepper = false

    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Text("Enter Distance Travelled")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Form {
                    
                    if selectedVehicles.contains("Private") || selectedVehicles.contains("Cabs") || selectedVehicles.contains("Carpool") {
                        Section(header: Text("Cars")) {
                            if selectedVehicles.contains("Private") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Private")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Private Car")
                                            Spacer()
                                        }.onTapGesture {
                                            showPrivateStepper.toggle()
                                        }
                                        if showPrivateStepper{
                                            VStack {
                                                Stepper(value: $privateDistance, in: 0...1000) {
                                                    Text("Distance: \(privateDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            if selectedVehicles.contains("Cabs") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Cabs")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Cab")
                                            Spacer()
                                        }.onTapGesture {
                                            showCabsStepper.toggle()
                                        }
                                        if showCabsStepper {
                                            VStack {
                                                Stepper(value: $cabsDistance, in: 0...1000) {
                                                    Text("Distance: \(cabsDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            if selectedVehicles.contains("Carpool") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Carpool")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Carpool")
                                            Spacer()
                                        }.onTapGesture {
                                            showCarpoolStepper.toggle()
                                        }
                                        if showCarpoolStepper {
                                            VStack {
                                                Stepper(value: $carpoolDistance, in: 0...1000) {
                                                    Text("Distance: \(carpoolDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if selectedVehicles.contains("Ordinary") || selectedVehicles.contains("AC") || selectedVehicles.contains("Deluxe") {
                        Section(header: Text("Bus")) {
                            if selectedVehicles.contains("Ordinary") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Ordinary")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Ordinary Bus")
                                            Spacer()
                                        }.onTapGesture {
                                            showOrdinaryStepper.toggle()
                                        }
                                        if showOrdinaryStepper {
                                            VStack {
                                                Stepper(value: $ordinaryDistance, in: 0...1000) {
                                                    Text("Distance: \(ordinaryDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            if selectedVehicles.contains("AC") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("AC")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("AC Bus")
                                            Spacer()
                                        }.onTapGesture {
                                            showACStepper.toggle()
                                        }
                                        if showACStepper {
                                            VStack {
                                                Stepper(value: $acDistance, in: 0...1000) {
                                                    Text("Distance: \(acDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }

                                    }
                                }
                            }
                            if selectedVehicles.contains("Deluxe") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Deluxe")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Deluxe Bus")
                                            Spacer()
                                        }.onTapGesture {
                                            showDeluxeStepper.toggle()
                                        }
                                        if showDeluxeStepper {
                                            VStack {
                                                Stepper(value: $deluxeDistance, in: 0...1000) {
                                                    Text("Distance: \(deluxeDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if selectedVehicles.contains("Local Train") || selectedVehicles.contains("Metro") {
                        Section(header: Text("Train")) {
                            if selectedVehicles.contains("Local Train") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Local Train")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Local Train")
                                            Spacer()
                                        }.onTapGesture {
                                            showLocalTrainStepper.toggle()
                                        }
                                        if showLocalTrainStepper {
                                            VStack {
                                                Stepper(value: $localTrainDistance, in: 0...1000) {
                                                    Text("Distance: \(localTrainDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            if selectedVehicles.contains("Metro") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Metro")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Metro")
                                            Spacer()
                                        }.onTapGesture {
                                            showMetroStepper.toggle()
                                        }
                                        if showMetroStepper {
                                            VStack {
                                                Stepper(value: $metroDistance, in: 0...1000) {
                                                    Text("Distance: \(metroDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if selectedVehicles.contains("Pillion") || selectedVehicles.contains("Sharing") || selectedVehicles.contains("Magic") {
                        Section(header: Text("Auto")) {
                            if selectedVehicles.contains("Pillion") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Pillion")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Pillion Auto")
                                            Spacer()
                                        }.onTapGesture {
                                            showPillionStepper.toggle()
                                        }
                                        if showPillionStepper {
                                            VStack {
                                                Stepper(value: $pillionDistance, in: 0...1000) {
                                                    Text("Distance: \(pillionDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            if selectedVehicles.contains("Sharing") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Sharing")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Sharing Auto")
                                            Spacer()
                                        }.onTapGesture {
                                            showSharingStepper.toggle()
                                        }
                                        if showSharingStepper {
                                            VStack {
                                                Stepper(value: $sharingDistance, in: 0...1000) {
                                                    Text("Distance: \(sharingDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            if selectedVehicles.contains("Magic") {
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image("Magic")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24, height: 24)
                                            Text("Magic Auto")
                                            Spacer()
                                        }.onTapGesture {
                                            showMagicStepper.toggle()
                                        }
                                        if showMagicStepper {
                                            VStack {
                                                Stepper(value: $magicDistance, in: 0...1000) {
                                                    Text("Distance: \(magicDistance) km")
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    
                    Button("Next") {
                        print("Private Distance Travelled: \(privateDistance)")
                        //authenticate user
                        showingNextScreen.toggle()
                        
                    }
                    .foregroundColor(.white)
                    .frame(width:201, height:44)
                    .background(Color.mainGreen)
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
            VehicleDetails(selectedVehicles: ["Private", "Cabs", "Carpool","AC","Ordinary","Deluxe","",])
        }
    }
