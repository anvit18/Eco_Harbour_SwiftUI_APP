//
//  UserManager.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 18/03/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser{
    let userId:String
    let email:String?
    let photoUrl:String?
    let dateCreated:Date?
}

struct HistoryViewData{
    var documents: [String: [String: Any]] = [:]
}

struct LatestDistanceData{
    let userEmission:Int
    let autoDistance:Int
    let busDistance:Int
    let carDistance:Int
    let carpoolDistance:Int
    let trainDistance:Int
}

private func formattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d-MMM-YY"
    return dateFormatter.string(from: date)
}



final class UserManager{
    
    static let shared = UserManager()
    private init(){ }
    
    //Creating new user document in a collection
    func createNewUser(auth:AuthDataResultModel) async throws{
        var userData: [String:Any]=[
            "user_id":auth.uid,
            "date_created":Timestamp()
        ]
        if let email = auth.email{
            userData["email"]=email
        }
        if let photoUrl = auth.photUrl{
            userData["photo_url"]=photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData,merge: false)
    }
    
    //Getting user data from collection
    func getUser(userId:String) async throws->DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId=data["user_id"] as? String else{
            throw URLError(.badServerResponse)
        }
        
        let dateCreated=data["date_created"] as? Date
        let email=data["email"] as? String
        let photoUrl=data["photo_url"] as? String
        
        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
    }
    
    
    //Insert Record view data in document
    func saveRecordViewData(auth: AuthDataResultModel, userEmissions: Double, selectedDate: String, carDistance: Int, busDistance: Int, trainDistance: Int, carPoolDistance: Int, autoDistance: Int) async throws {
        var recordViewDataUpload: [String: Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp(),
            "user_emissions": userEmissions,
            "selected_date": selectedDate,
            "car_distance": carDistance,
            "bus_distance": busDistance,
            "train_distance": trainDistance,
            "car_pool_distance": carPoolDistance,
            "auto_distance": autoDistance
        ]
        
        if let email = auth.email {
            recordViewDataUpload["email"] = email
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).collection("date").document(selectedDate).setData(recordViewDataUpload, merge: true)
    }
    
    
    //Fetch record from document according to date
    func getHistoryViewData(userId:String) async throws->HistoryViewData{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).collection("date").getDocuments()
        
        var historyViewData = HistoryViewData()
        
        for document in snapshot.documents {
            print("\(document.documentID) => \(document.data())")
            historyViewData.documents[document.documentID] = document.data()
            print("\nHistory View data uploaded")
          }
        
        return historyViewData
    }
    
    
    
    // Function to get the latest distance data
    func getLatestDistanceData(userId: String) async throws -> LatestDistanceData? {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).collection("date").getDocuments()
        
        // Create a dictionary to hold document data
        var documents: [String: [String: Any]] = [:]
        
        for document in snapshot.documents {
            let documentData = document.data()
            let documentId = document.documentID
            documents[documentId] = documentData
        }

        // Filter documents to include only those on or before today's date
        let currentDate = Date()
        let formattedCurrentDate = formattedDate(currentDate)
        let filteredDocuments = documents.filter { $0.key <= formattedCurrentDate }
        
        // Get the document with the latest date among the filtered documents
        if let closestDocument = filteredDocuments.max(by: { $0.key < $1.key }) {
            // Extract distance data
            let userEmission = closestDocument.value["user_emissions"] as? Int ?? 0
            let autoDistance = closestDocument.value["auto_distance"] as? Int ?? 0
            let busDistance = closestDocument.value["bus_distance"] as? Int ?? 0
            let carDistance = closestDocument.value["car_distance"] as? Int ?? 0
            let carpoolDistance = closestDocument.value["car_pool_distance"] as? Int ?? 0
            let trainDistance = closestDocument.value["train_distance"] as? Int ?? 0

            return LatestDistanceData(userEmission: userEmission, autoDistance: autoDistance, busDistance: busDistance, carDistance: carDistance, carpoolDistance: carpoolDistance, trainDistance: trainDistance)
        }
        
        return nil
    }

}
