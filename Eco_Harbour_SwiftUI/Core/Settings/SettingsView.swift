//
//  SettingsView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by Sarthak_AppDev on 11/03/24.
//

import SwiftUI

@MainActor
final class settingsViewModel:ObservableObject{
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel=settingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List{
            Button("Log Out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView=true
                    } catch{
                        print("Error: \(error)")
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack{
        SettingsView(showSignInView: .constant(false))
    }
    
}
