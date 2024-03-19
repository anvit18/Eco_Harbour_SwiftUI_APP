//
//  SettingsViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/03/24.
//

import Foundation


@MainActor
final class settingsViewModel:ObservableObject{
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}
