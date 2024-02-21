import SwiftUI

struct VehicleDetails: View {
    @State private var selectedTime = Date()
    @State private var showingNextScreen = false

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            VStack {
                
                Form {
                    Section(header: Text("Bus")) {
                        
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "bus.fill")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "bus.doubledecker")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                    }
                    
                    Section(header: Text("Car")) {
                        NavigationLink(destination: VehcileDetails_CarDetails()) {
                            Label("Details", systemImage: "car.fill")
                        }
                        
                        NavigationLink(destination: Text("Security")) {
                            Label("Details", systemImage: "bolt.car.fill")
                        }
                        
                    }
                    
                    Section(header: Text("Auto")) {
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "carseat.right.1.fill")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "carseat.right.3.fill")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "truck.pickup.side.fill")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                        
                        
                    }
                    
                    Section(header: Text("Train")) {
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "train.side.rear.car")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("Preferences")) {
                                Label("Time Travelled", systemImage: "train.side.front.car")
                            }
                            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute]).padding(.trailing, 20)
                        }
                    }
                }
                
                Button("Next") {
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
        VehicleDetails()
    }
}
