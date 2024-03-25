//
//  AppHistoryModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 24/03/24.
//

import Foundation

@MainActor
final class AppHistoryModel: ObservableObject{
    @Published private(set) var historyData: HistoryViewData?=nil
    
    func loadCurrentUser() async throws{
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        self.historyData=try await UserManager.shared.getHistoryViewData(userId: authDataResult.uid)
    }
}
