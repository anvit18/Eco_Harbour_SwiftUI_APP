//
//  ProfileView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/03/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject{
    @Published private(set) var user: DBUser?=nil
    
    func loadCurrentUser() async throws{
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        self.user=try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel=ProfileViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        List{
            if let user = viewModel.user{
                Text("UserId: \(user.userId)")
                
                if let dateCreated = user.dateCreated{
                    Text("Date Created: \(dateCreated)")
                }else{
                    Text("Date not displaying")
                }
                
                if let email = user.email{
                    Text("email: \(email)")
                }
            }
            
        }
        .task{
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink{
                    SettingsView(showSignInView: $showSignInView)
                }label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView(showSignInView:.constant(false))
    }
}
