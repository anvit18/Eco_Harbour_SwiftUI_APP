import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var userEmission: Double = 0.0
    @Published var hasVisitedHistoryView = false
    @Published var datePicked: Date? = nil
}
