import SwiftUI

struct HomePageDashboardView2: View {
    
    //IMPORTANT BACKEND STUFF
    @StateObject private var viewModel=settingsViewModel()
    @Binding var showSignInView: Bool
    
    
    
    
    
    
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
    @State private var userLoggedIn = true
    
    
    
    var body: some View {
        
        ZStack {
            
            Color.white.ignoresSafeArea()
            VStack {
                HStack(spacing: 0) {
                    Text("Eco")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                    
                    Text("Track")
                        .foregroundStyle(Color.black)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink{
                        SettingsView(showSignInView: $showSignInView)
                    }label: {
                        Image(systemName: "gear")
                            .font(.headline)
                            .padding(.trailing,20)
                    }
                    
                }
                //                NavigationLink(destination: Login_Signup_Page(), isActive: $showingLoginScreen) {
                //                    EmptyView()
                //                }
                
                
                
                TabView {
                    //Color.white.ignoresSafeArea()
                    
                    // Icon 1
                    dashboardView2(showSignInView: .constant(false), privateDistance: 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                        .tabItem {
                            Image(systemName: "house.fill")
                                .resizable().foregroundColor(.black)
                                .frame(width: 50, height: 50) // Adjust the icon size
                            Text("Home").foregroundColor(.black)
                        }
                    
                    AppHistory()
                        .tabItem {
                            Image(systemName: "clock")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50) // Adjust the icon size
                            Text("History")
                                .foregroundColor(.black)
                        }
                    
                    RecordView2(showSignInView: .constant(false))
                        .tabItem {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                            // Adjust the icon size
                            Text("Record").foregroundColor(.black)
                        }
                    
                        .accentColor(.mainGreen)
                    // .background(Color.mainGreen) // Set the background color to mainGreen
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(userData)
                        .environmentObject(distanceViewModel)
                    
                }
                
            }.navigationBarHidden(true)
        }
    }
}


struct HomePageDashboardView2_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDashboardView2(showSignInView: .constant(false),privateDistance : 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())
    }
}
