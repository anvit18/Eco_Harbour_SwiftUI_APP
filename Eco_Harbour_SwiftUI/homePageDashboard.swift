import SwiftUI

struct homePageDashboard: View {
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    
    let privateDistance: Int
        let cabsDistance: Int
        let carpoolDistance: Int
        let localTrainDistance: Int
        let metroDistance: Int
        let pillionDistance: Int
        let sharingDistance: Int
        let magicDistance: Int
        let ordinaryDistance: Int
        let acDistance: Int
        let deluxeDistance: Int
    
    //let userEmission: Double
    
    let nationalAverageEmission: Double = 1910
    var userCarbonEmission: Double = 2100
    @State private var isActionSheetPresented = false
    @State private var showingLoginScreen = false
    @State private var userName  = "Anvit"
    
    var body: some View {
        
        ZStack {
            
            //Color.mainGreen.opacity(0.1).ignoresSafeArea()
            VStack {
                HStack(spacing: 0) {
                    Text("Eco")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                    
                    Text("Harbour")
                        .foregroundStyle(Color.green)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        // Add action for button tap
                        print("Button tapped!")
                    }){
                        HStack {
                            Button(action: {
                                // Show the action sheet when the button is tapped
                                isActionSheetPresented = true
                            }) {
                                Image(systemName: "line.horizontal.3") .resizable()
                                    .foregroundColor(.mainGreen)
                                    .frame(width: 30, height: 30)
                            }
                            .actionSheet(isPresented: $isActionSheetPresented) {
                                ActionSheet(title: Text("Choose Option"), buttons: [
                                    .default(Text("Settings")) {
                                        //userName = "Vishal"
                                        // Add your action for Priya
                                    },

                                    .default(
                                        Text("Add Account")) {
                                        showingLoginScreen.toggle()
                                        // Add your action for the third option
                                    },
                                    .destructive(
                                        Text("Log Out")
                                            .font(.title)
                                            .foregroundColor(.red)
                                    ) {
                                        showingLoginScreen.toggle()
                                        // Add your action for the third option
                                    },
                                    .cancel()
                                ])
                            }
                            .padding(.bottom, 10)
                            // Set the image color
                        }
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }.padding(.trailing, 10)
                }
                NavigationLink(destination: Login_Signup_Page(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
                
               
                
                TabView {
                    
                    // Icon 1
                    dashboardView(privateDistance: 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                        .tabItem {
                            Image(systemName: "house.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the icon size
                            Text("Home")
                        }
                    
                    // Icon 2
//                    historyView(
//                                        selectedCategory: "",
//                                        selectedDate: Date(),
//                                        carType: "",
//                                        carTime: "",
//                                        busType: "",
//                                        busTime: "",
//                                        trainType: "",
//                                        trainTime: "",
//                                        carPoolType: "",
//                                        carPoolTime: "",
//                                        autoType: "",
//                                        autoTime: "",
//                                        dummyVar: "",
//                                        fuel: "",
//                                        numberOfPassengers: ""
//                                    )
//                        .tabItem {
//                            Image(systemName: "leaf.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50) // Adjust the icon size
//                            Text("History")
//                        }
                    
                    recordView()
                        .tabItem {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            // Adjust the icon size
                            Text("Record")
                        }
                }
                .accentColor(.mainGreen)
                // .background(Color.mainGreen) // Set the background color to mainGreen
                .edgesIgnoringSafeArea(.all)
                .environmentObject(userData)
                .environmentObject(distanceViewModel)
                
                
                
            }.navigationBarHidden(true)
        }
    }
    }
    
    
struct homePageDashboard_Previews: PreviewProvider {
        static var previews: some View {
            homePageDashboard(privateDistance : 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)

        }
    }
