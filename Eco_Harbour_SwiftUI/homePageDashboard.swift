import SwiftUI

struct homePageDashboard: View {
    
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
                                    .default(Text("Profile")) {
                                        //userName = "Vishal"
                                        // Add your action for Priya
                                    },
                                    .default(Text("Account")) {
                                        //userName = "Rahul"
                                        // Add your action for Rohan
                                    },
                                    .default(Text("Dark Mode")) {
                                        //userName = "Anvit"
                                        // Add your action for Rohan
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
                    
                    dashboardView()
                        .tabItem {
                            Image(systemName: "house.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the icon size
                            Text("Home")
                        }
                    
                    // Icon 2
                    historyView()
                        .tabItem {
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the icon size
                            Text("History")
                        }
                    
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
                
                
                
            }.navigationBarHidden(true)
        }
    }
    }
    
    
struct homePageDashboard_Previews: PreviewProvider {
        static var previews: some View {
            homePageDashboard()
        }
    }

