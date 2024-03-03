import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var distanceViewModel: DistanceViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading) // Align title to left
            
            // Display the date picked at the top left corner
            if userData.datePicked != nil{
                Text("Date: \(formattedDate(userData.datePicked!))")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading) // Align date to left
            }
            
            
            // Display vehicle distance data below the date
            // Display vehicle distance data below the date
            VStack(alignment: .leading) {
                if distanceViewModel.privateVDistance != 0 {
                    Text("Private Car Distance: \(distanceViewModel.privateVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.cabsVDistance != 0 {
                    Text("Cab Distance: \(distanceViewModel.cabsVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.carpoolVDistance != 0 {
                    Text("Car Pool Distance: \(distanceViewModel.carpoolVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.localTrainVDistance != 0 {
                    Text("Local Train Distance: \(distanceViewModel.localTrainVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.metroVDistance != 0 {
                    Text("Metro Distance: \(distanceViewModel.metroVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.pillionVDistance != 0 {
                    Text("Pillion Auto Distance: \(distanceViewModel.pillionVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.sharingVDistance != 0 {
                    Text("Sharing Auto Distance: \(distanceViewModel.sharingVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.magicVDistance != 0 {
                    Text("Magic Auto Distance: \(distanceViewModel.magicVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.ordinaryVDistance != 0 {
                    Text("Ordinary Bus Distance: \(distanceViewModel.ordinaryVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.acVDistance != 0 {
                    Text("AC Bus Distance: \(distanceViewModel.acVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
                if distanceViewModel.deluxeVDistance != 0 {
                    Text("Deluxe Bus Distance: \(distanceViewModel.deluxeVDistance)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to left
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Align VStack to left

            
            Spacer()
        }
    }
    
    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(UserData())
            .environmentObject(DistanceViewModel())
    }
}
