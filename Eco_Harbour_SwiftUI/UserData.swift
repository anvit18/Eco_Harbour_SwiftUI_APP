import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var userEmission: Double = 0.0
    @Published var datePicked: Date? = nil
}
