import SwiftUI

struct VehicleDetails: View {
    
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var distanceViewModel : DistanceViewModel

    
    let selectedVehicles: Set<String>
    @State private var selectedTime = Date()
    @State private var showingNextScreen = false
    @State private var showAlert = false
    @State private var isShowingNotification = false
    @State private var notificationText: String?
    
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
    
    // Emission Factor Variables, set dummy for now
      @State private var privateFactor: Double = 20
      @State private var cabsFactor: Double = 18
      @State private var carpoolFactor: Double = 16
      @State private var localTrainFactor: Double = 4
      @State private var metroFactor: Double = 8
      @State private var pillionFactor: Double = 13
      @State private var sharingFactor: Double = 7
      @State private var magicFactor: Double = 9
      @State private var ordinaryFactor: Double = 4
      @State private var acFactor: Double = 10
      @State private var deluxeFactor: Double = 5
    
    
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
    
    var userEmissions: Double {
            return (Double(privateDistance) * privateFactor) +
                   (Double(cabsDistance) * cabsFactor) +
                   (Double(carpoolDistance) * carpoolFactor) +
                   (Double(localTrainDistance) * localTrainFactor) +
                   (Double(metroDistance) * metroFactor) +
                   (Double(pillionDistance) * pillionFactor) +
                   (Double(sharingDistance) * sharingFactor) +
                   (Double(magicDistance) * magicFactor) +
                   (Double(ordinaryDistance) * ordinaryFactor) +
                   (Double(acDistance) * acFactor) +
                   (Double(deluxeDistance) * deluxeFactor)
        }
    
    

    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            VStack {
                
                
                Form {
                  //  Color.white.ignoresSafeArea()
                    
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $privateDistance, in: 0...1000, step: 5) {
                                                Text(" \(privateDistance) km")
                                                    .padding(.trailing,-85)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            //Spacer()
                                            Stepper(value: $cabsDistance, in: 0...1000, step: 5) {
                                                Text("   \(cabsDistance) km")
                                                    .padding(.trailing,-170)
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
                                            Text("Car Pool")
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $carpoolDistance, in: 0...1000, step: 5) {
                                                Text(" \(carpoolDistance) km")
                                                    .padding(.trailing,-115)
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
                                            Spacer()
                                           
                                            Spacer()
                                            Stepper(value: $ordinaryDistance, in: 0...1000, step: 5) {
                                                Text(" \(ordinaryDistance) km")
                                                    .padding(.trailing,-95)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $acDistance, in: 0...1000, step: 5) {
                                                Text(" \(acDistance) km")
                                                    .padding(.trailing,-125)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $deluxeDistance, in: 0...1000, step: 5) {
                                                Text(" \(deluxeDistance) km")
                                                    .padding(.trailing,-70)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $localTrainDistance, in: 0...1000, step: 5) {
                                                Text(" \(localTrainDistance) km")
                                                    .padding(.trailing,-75)
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
                                            Text("Metro Distance")
                                            Spacer()
                                            Spacer()
                                            
                                            //Spacer()
                                            Stepper(value: $metroDistance, in: 0...1000, step: 5) {
                                                Text(" \(metroDistance) km")
                                                    .padding(.trailing,-45)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $pillionDistance, in: 0...1000,  step: 5) {
                                                Text(" \(pillionDistance) km")
                                                    .padding(.trailing,-75)
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
                                           
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $sharingDistance, in: 0...1000, step: 5) {
                                                Text(" \(sharingDistance) km")
                                                    .padding(.trailing,-65)
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
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            Stepper(value: $magicDistance, in: 0...1000,  step: 5) {
                                                Text(" \(magicDistance) km")
                                                    .padding(.trailing, -65)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                //                    Button("") {
                //
                //                        showAlert = true
                //                        //authenticate user
                //                        print("Private Distance Travelled: \(privateDistance)")
                //                        print("Cabs Distance Travelled: \(cabsDistance)")
                //                        print("Carpool Distance Travelled: \(carpoolDistance)")
                //                        print("Local Train Distance Travelled: \(localTrainDistance)")
                //                        print("Metro Distance Travelled: \(metroDistance)")
                //                        print("Pillion Distance Travelled: \(pillionDistance)")
                //                        print("Sharing Distance Travelled: \(sharingDistance)")
                //                        print("Magic Distance Travelled: \(magicDistance)")
                //                        print("Ordinary Distance Travelled: \(ordinaryDistance)")
                //                        print("AC Distance Travelled: \(acDistance)")
                //                        print("Deluxe Distance Travelled: \(deluxeDistance)")
                //
                //                        print("User Emission: \(userEmissions)")
                //
                //                        userData.userEmission = userEmissions
                //                        distanceViewModel.privateVDistance = privateDistance
                //                        distanceViewModel.cabsVDistance = cabsDistance
                //                        distanceViewModel.carpoolVDistance = carpoolDistance
                //                        distanceViewModel.localTrainVDistance = localTrainDistance
                //                        distanceViewModel.metroVDistance = metroDistance
                //                        distanceViewModel.pillionVDistance = pillionDistance
                //                        distanceViewModel.sharingVDistance = sharingDistance
                //                        distanceViewModel.magicVDistance = magicDistance
                //                        distanceViewModel.ordinaryVDistance = ordinaryDistance
                //                        distanceViewModel.acVDistance = acDistance
                //                        distanceViewModel.deluxeVDistance = deluxeDistance
                //
                //                    }
                //                    .foregroundColor(.white)
                //                    .frame(width:180, height:44)
                //                    .background(Color.mainGreen)
                //                    .cornerRadius(10)
                //                    .alert(isPresented: $showAlert) {
                //                        Alert(
                //                            title: Text("Data Logged Successfully!"),
                //                            dismissButton: .default(Text("OK"))
                //                        )
                //                    }
            
                    
      Button("Next") {
                        //authenticate user
//                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
//                                                isShowingNotification = false
//                                                notificationText = nil
//
//                                                // Navigate to the next screen here
//                                                showingNextScreen.toggle()
//                                            }
                        showingNextScreen.toggle()
                        
                       // showAlert = true
                        //authenticate user
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
                        
                        print("User Emission: \(userEmissions)")
                        
                        userData.userEmission = userEmissions
                        distanceViewModel.privateVDistance = privateDistance
                        distanceViewModel.cabsVDistance = cabsDistance
                        distanceViewModel.carpoolVDistance = carpoolDistance
                        distanceViewModel.localTrainVDistance = localTrainDistance
                        distanceViewModel.metroVDistance = metroDistance
                        distanceViewModel.pillionVDistance = pillionDistance
                        distanceViewModel.sharingVDistance = sharingDistance
                        distanceViewModel.magicVDistance = magicDistance
                        distanceViewModel.ordinaryVDistance = ordinaryDistance
                        distanceViewModel.acVDistance = acDistance
                        distanceViewModel.deluxeVDistance = deluxeDistance
                        
//                        notificationText = "Data logged successfully!"
//                                            isShowingNotification = true
                        
                    }
                    .foregroundColor(.white)
                    .frame(width:180, height:44)
                    .background(Color.mainGreen)
                    .cornerRadius(10)
//                    .alert(isPresented: $showAlert) {
//                        Alert(
//                            title: Text("Data Logged Successfully!"),
//                            dismissButton: .default(Text("OK"))
//                        )
//                    }
//                if isShowingNotification {
//                    NotificationView(text: notificationText ?? "", onClose: {
//                        // Close notification when tapped
//                        isShowingNotification = false
//                        notificationText = nil
//                        
//                        // Navigate to the next screen here
//                        showingNextScreen.toggle()
//                    })
//                    .frame(maxWidth: .infinity)
//                    //.background(Color.mainGreen.opacity(0.7))
//                    .foregroundColor(.white)
//                    .transition(.move(edge: .top))
//                    .animation(.easeInOut)
//                    .edgesIgnoringSafeArea(.top)
//                }
                    
                    NavigationLink(destination: homePageDashboard(showSignInView: .constant(false), privateDistance: Int(userEmissions), cabsDistance: privateDistance, carpoolDistance: cabsDistance, localTrainDistance: carpoolDistance, metroDistance: localTrainDistance, pillionDistance: metroDistance, sharingDistance: pillionDistance, magicDistance: sharingDistance, ordinaryDistance: magicDistance, acDistance: ordinaryDistance, deluxeDistance: acDistance), isActive: $showingNextScreen) {
                        EmptyView()
                    }
                }.navigationTitle("Vehicle Details")
                    .navigationBarTitle("Details")
            }
        }
        }
    

//struct NotificationView: View {
//    var text: String
//    var onClose: () -> Void
//
//    var body: some View {
//        HStack {
//            Text(text)
//                .foregroundColor(.white)
//                .padding()
//                .background(Color.mainGreen.opacity(0.8))
//                .cornerRadius(10)
//
//            Spacer()
//
//            Button(action: {
//                onClose()
//            }) {
//                Image(systemName: "xmark.circle.fill")
//                    .foregroundColor(.white)
//            }
//            .padding()
//        }
//        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
//    }
//}


    struct VehicleDetails_Previews: PreviewProvider {
        static var previews: some View {
            VehicleDetails(selectedVehicles: ["Private", "Cabs", "Carpool","AC","Ordinary","Deluxe","",])
        }
    }
