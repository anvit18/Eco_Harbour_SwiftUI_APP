import SwiftUI
import Charts

struct VehicleStatisticsView: View {
    @StateObject private var viewModel = StatisticsViewModel()
    @State private var selectedEmissions: Int?
    @State private var emissionData: [Emissions] = []
    @State private var selectedType: Emissions?
    @State private var cumulativeEmissions: Double = 0 // New state variable for cumulative emissions
    @State private var progress: CGFloat = 0.2 // example progress value
    
    struct Emissions: Identifiable {
        var id = UUID()
        var type: String
        var emissions: Int
    }
    
    func updateData() {
        if let data = viewModel.data {
            let carEmissionOverall = data.carDistanceOverall * 1
            let carPoolEmissionOverall = data.carpoolDistanceOverall * 2
            let autoEmissionOverall = data.autoDistanceOverall * 3
            let busEmissionOverall = data.busDistanceOverall * 4
            let trainEmissionOverall = data.trainDistanceOverall * 5
            
            emissionData = [
                Emissions(type: "Car", emissions: carEmissionOverall + carPoolEmissionOverall),
                Emissions(type: "Auto", emissions: autoEmissionOverall),
                Emissions(type: "Bus", emissions: busEmissionOverall),
                Emissions(type: "Train", emissions: trainEmissionOverall)
            ]
            
            // Calculate cumulative emissions
            cumulativeEmissions = emissionData.reduce(0) { $0 + Double($1.emissions) }
            
            selectedType = emissionData.max(by: { $0.emissions < $1.emissions })
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vehicle Type Statistics")
                .font(.subheadline)
            
            Text("\(emissionData.map { $0.emissions }.reduce(0, +))")
                .font(.largeTitle)

            
            ForEach(emissionData.indices, id: \.self) { index in
                let data = emissionData[index]
                let percentage = Double(data.emissions) / cumulativeEmissions
                
                HStack {
                    CircularProgressView(progress: percentage)
                        .frame(width: 60, height: 60) // Adjust size as needed
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(data.type.uppercased())
                            .font(.headline)
                        Text("\(data.emissions) Kg CO\u{2082}")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        if index != emissionData.count - 1 {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                if index != emissionData.count - 1 {
                    Divider()
                }
            }
        }

        .onAppear {
            updateData()
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}






struct CircularProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            // Background for the progress bar
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.1)
                .foregroundColor(.blue)
            
            // Foreground or the actual progress bar with gradient color
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(.blue)
                .fill(
                    AngularGradient(gradient: Gradient(colors: [.green,.red,.green]), center: .center)
                    )
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            // Text to display the percentage
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .foregroundColor(.blue)
        }
    }
    
}








struct VehicleStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleStatisticsView()
    }
}



















//            Chart(emissionData, id: \.type) { emission in
//                SectorMark(
//                    angle: .value("Emissions", Double(emission.emissions)),
//                    innerRadius: .ratio(0.618),
//                    angularInset: 1.5
//                )
//                .cornerRadius(5.0)
//                .foregroundStyle(by: .value("Type", emission.type))
//                .annotation(position: .overlay) {
//                    VStack{
//                        Text("\(emission.emissions)")
//                            .font(.subheadline)
//                            .bold()
//                            .foregroundStyle(.black)
//                    }
//                }
//                .opacity(emission.type == (selectedType?.type ?? "") ? 1 : 0.3)
//            }
//            .chartLegend(alignment: .center, spacing: 18)
//            .chartAngleSelection(value: $selectedEmissions)
//            .scaledToFit()
//            .chartForegroundStyleScale(domain: .automatic, range: [.red, .green, .blue, .yellow])
//            .frame(height: 300)
//            .chartBackground { chartProxy in
//                GeometryReader { geometry in
//                    let frame = geometry[chartProxy.plotFrame!]
//                    VStack {
//                        Text("Cumulative Emissions: \(Int(cumulativeEmissions))") // Display cumulative emissions
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                            .opacity(selectedType == nil || selectedType?.type == emissionData.first?.type ? 1 : 0)
//                        Text("Most Emissions from")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                            .opacity(selectedType == nil || selectedType?.type == emissionData.first?.type ? 1 : 0)
//                        Text(selectedType?.type ?? emissionData.first?.type ?? "")
//                            .font(.title2.bold())
//                            .foregroundColor(.primary)
//                        Text("\(selectedType?.emissions ?? emissionData.first?.emissions ?? 0) Kg CO2")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                    }
//                    .position(x: frame.midX, y: frame.midY)
//                }
//            }
