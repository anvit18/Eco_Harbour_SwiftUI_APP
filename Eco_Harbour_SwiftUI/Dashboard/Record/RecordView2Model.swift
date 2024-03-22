//
//  RecordView2Model.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 22/03/24.
//

import Foundation

@MainActor
final class RecordView2Model: ObservableObject{
    @Published var userEmissions=""
    @Published var selectedDate=""
    
    @Published var privateDistance=""
    @Published var cabsDistance=""
    @Published var carpoolDistance=""
    @Published var localTrainDistance=""
    @Published var metroDistance=""
    @Published var pillionDistance=""
    @Published var sharingDistance=""
    @Published var magicDistance=""
    @Published var ordinaryDistance=""
    @Published var acDistance=""
    @Published var deluxeDistance=""
    
    func sendRecordViewData() async throws{
        
        
        let authDataResult=try AuthenticationManager.shared.getAuthenticatedUser()
        
        try await UserManager.shared.saveRecordViewData(auth: authDataResult, userEmissions: userEmissions, selectedDate: selectedDate, privateDistance: privateDistance, cabsDistance: cabsDistance, carpoolDistance: carpoolDistance, localTrainDistance: localTrainDistance, metroDistance: metroDistance, pillionDistance: pillionDistance, sharingDistance: sharingDistance, magicDistance: magicDistance, ordinaryDistance: ordinaryDistance, acDistance: acDistance, deluxeDistance: deluxeDistance)
        
    }
}
