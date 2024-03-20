

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool=false
    
    var body: some View {
        ZStack{
            NavigationStack{
                HomePageDashboardView2(showSignInView: $showSignInView,privateDistance : 0, cabsDistance: 0, carpoolDistance: 0, localTrainDistance: 0, metroDistance: 0, pillionDistance: 0, sharingDistance: 0, magicDistance: 0, ordinaryDistance: 0, acDistance: 0, deluxeDistance: 0)
                    .environmentObject(UserData())
                    .environmentObject(DistanceViewModel())
                
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView=authUser==nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                SignUpEmailView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
