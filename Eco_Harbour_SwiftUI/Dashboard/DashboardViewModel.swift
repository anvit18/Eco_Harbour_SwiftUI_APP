//
//  DashboardViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 19/03/24.
//

import Foundation

@MainActor
final class DashboardViewModel: ObservableObject{
    @Published private(set) var user: DBUser?=nil
    
    func loadCurrentUser() async throws{
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        self.user=try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}
