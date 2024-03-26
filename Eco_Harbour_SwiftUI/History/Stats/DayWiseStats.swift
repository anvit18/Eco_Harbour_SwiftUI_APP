import SwiftUI

struct Bar1: Identifiable {
    let id = UUID()
    var name: String
    var day: String
    var value: Double
    var color: Color
    var isToday: Bool
}

struct DayWiseStats: View {
    @EnvironmentObject var userData: UserData // Assuming user data is provided by UserData object
    @State private var bars: [Bar1] = []
    
    private func generateBars() {
        // Get the current day index (0 for Monday, 1 for Tuesday, ..., 6 for Sunday)
        let currentDayIndex = Calendar.current.component(.weekday, from: Date()) - 2

        // Weekday initials
        let daysInitials = ["M", "T", "W", "T", "F", "S", "S"]

        var bars = [Bar1]()

        for index in 0..<7 {
            // Calculate the day index based on the current day
            let dayIndex = (currentDayIndex + index) % 7
            let isToday = index == 0 // Check if it's the current day

            let color: Color
            if isToday {
                color = .blue // Color for the current day
            } else {
                // Use a color based on the user emission value
                let userEmission = userData.userEmission
                if userEmission > 1000 {
                    color = .red
                } else if userEmission > 900 {
                    color = .yellow
                } else {
                    color = .green
                }
            }

            let bar = Bar1(name: "\(index)", day: daysInitials[dayIndex], value: userData.userEmission, color: color, isToday: isToday)
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
                                .frame(width: 35, height: CGFloat(bar.value * 0.1), alignment: .bottom) // Increased frame size
                                .cornerRadius(6)

                            if bar.isToday {
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 40) // Increased circle size
                                    .offset(x: 0, y: -10) // Adjust offset
                            }

                            Text("\(Int(bar.value))")
                                .foregroundColor(.white)
                        }
                        Text(bar.day)
                            .font(.caption)
                    }
                    .onHover { hovering in
                        // Show user emission value when hovering
                        if hovering && bar.isToday {
                            Text("\(userData.userEmission)") // Show user emission value
                                .foregroundColor(.black)
                                .padding(4)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
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
        return DayWiseStats()
            .environmentObject(UserData()) // Initialize with user data object
    }
}
