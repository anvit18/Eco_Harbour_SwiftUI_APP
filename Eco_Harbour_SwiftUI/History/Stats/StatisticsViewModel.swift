//
//  StatisticsViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 27/03/24.
//

import Foundation

@MainActor
final class StatisticsViewModel: ObservableObject{
    @Published private(set) var user: DBUser?=nil
    @Published private(set) var data: OverallDistanceData?=nil
    
    func loadCurrentUser() async throws{
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        self.user=try await UserManager.shared.getUser(userId: authDataResult.uid)
        self.data=try await UserManager.shared.getOverallDistanceData(userId: authDataResult.uid)
    }
}
