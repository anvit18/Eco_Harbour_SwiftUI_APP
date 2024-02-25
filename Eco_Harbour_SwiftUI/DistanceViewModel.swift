//
//  DistanceViewModel.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 26/02/24.
//
import SwiftUI
import Combine


class DistanceViewModel: ObservableObject {
    @Published var privateVDistance: Int = 0
    @Published var cabsVDistance: Int = 0
    @Published var carpoolVDistance: Int = 0
    @Published var localTrainVDistance: Int = 0
    @Published var metroVDistance: Int = 0
    @Published var pillionVDistance: Int = 0
    @Published var sharingVDistance: Int = 0
    @Published var magicVDistance: Int = 0
    @Published var ordinaryVDistance: Int = 0
    @Published var acVDistance: Int = 0
    @Published var deluxeVDistance: Int = 0
}


