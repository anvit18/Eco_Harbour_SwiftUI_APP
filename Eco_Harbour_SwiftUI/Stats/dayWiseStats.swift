import SwiftUI

struct Bar: Identifiable {
    let id = UUID()
    var name: String
    var day: String
    var value: Double
    var color: Color
    var isToday: Bool
}

struct DayWiseStats: View {
    @EnvironmentObject var emissionDataViewModelWrapper: EmissionDataViewModelWrapper
    @State private var bars: [Bar] = []
    
    private func generateBars() {
        let emissionsData = emissionDataViewModelWrapper.emissionDataViewModel.last14DaysData
        let last7DaysData = emissionsData.suffix(7)
        
        var bars = [Bar]()
        let daysInitials = ["M", "T", "W", "T", "F", "S", "S"]
        let currentWeekday = Calendar.current.component(.weekday, from: Date()) - 1
        
        // Rearrange the days based on the current day's index
        let reorderedDaysInitials = Array(daysInitials[currentWeekday...] + daysInitials[..<currentWeekday])
        
        for (index, data) in last7DaysData.enumerated() {
            let color: Color
            if Double(data.1) > 1000 {
                color = .red
            } else if Double(data.1) > 900 {
                color = .yellow
            } else {
                color = .green
            }
            let dayIndex = (currentWeekday + index) % 7 // Calculate the index based on the reordered days
            let isToday = dayIndex == currentWeekday
            let bar = Bar(name: "\(index)", day: reorderedDaysInitials[dayIndex], value: Double(data.1), color: color, isToday: isToday)
            bars.append(bar)
        }
        
        self.bars = bars
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Emissions for the week")
                .font(.callout)
                .padding(.leading, 20)
                .foregroundStyle(.secondary)
            
            HStack(alignment: .bottom) {
                ForEach(bars) { bar in
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(bar.color)
                                .frame(width: 35, height: CGFloat(bar.value * 0.17), alignment: .bottom) // Increased frame size
                                .cornerRadius(6)
                            
                            if bar.isToday {
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 20, height: 40) // Increased circle size
                                    .offset(x: 0, y: -10) // Adjust offset
                            }
                            
                            Text("\(Int(bar.value))")
                                .foregroundColor(.white)
                        }
                        Text(bar.day)
                            .font(.caption)
                    }
                }
            }
            .frame(height: 240, alignment: .bottom)
            .padding(20)
            .background(Color.white)
            .cornerRadius(6)
        }
        .onAppear {
            generateBars()
        }
    }
}

struct DayWiseStats_Previews: PreviewProvider {
    static var previews: some View {
        let vehicleTypeDataProviderEnv = VehicleTypeDataProvider()
        return DayWiseStats()
            .environmentObject(vehicleTypeDataProviderEnv)
            .environmentObject(EmissionDataViewModelWrapper())
    }
}
