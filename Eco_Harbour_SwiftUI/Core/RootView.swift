

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool=false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ProfileView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView=authUser==nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
