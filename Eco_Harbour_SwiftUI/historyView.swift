//
//  historyView.swift
//  Eco_Harbour_SwiftUI
//
//  Created by user1 on 17/01/24.
//

import SwiftUI

struct historyView: View {
    
    @State private var showingNextScreen = false
    
    var body: some View {
      
        VStack {
            Text("Your previous logs appear here")
            
            Button("Log Data + ") {
                //authenticate user
                showingNextScreen.toggle()
                
            }
            .font(.headline)
            .foregroundColor(.black)
            .frame(width:201, height:44)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.top, 20)
            
            NavigationLink(destination: recordView(), isActive: $showingNextScreen){
                EmptyView()
            }
        }.navigationBarTitle("History")
    }
}

#Preview {
    historyView()
}
