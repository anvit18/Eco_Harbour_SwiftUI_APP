//
//  RecordView2Model.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 22/03/24.
//

import Foundation

@MainActor
final class RecordView2Model: ObservableObject{
    @Published var userEmissions=0.0
    @Published var selectedDate=""
    
    @Published var carDistance = 0
    @Published var busDistance = 0
    @Published var trainDistance = 0
    @Published var carPoolDistance = 0
    @Published var autoDistance = 0

    
    func sendRecordViewData() async throws{
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        
        try await UserManager.shared.saveRecordViewData(auth: authDataResult, userEmissions: userEmissions, selectedDate: selectedDate, carDistance: carDistance, busDistance: busDistance, trainDistance: trainDistance, carPoolDistance: carPoolDistance, autoDistance: autoDistance)

        
    }
}
