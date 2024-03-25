//import SwiftUI
//import Charts
//
//struct TopEmissionsView: View {
//    @State private var emissionsData: [Double] = [1200, 1000, 800, 600] // Replace with actual data
//    let categories = ["Car", "Auto", "Train", "Bus"]
//
//    var body: some View {
//        VStack {
//            Text("Top Emissions")
//                .font(.title)
//
//            BarChartView(data: ChartData(values: [
//                ("Car", emissionsData[0]),
//                ("Auto", emissionsData[1]),
//                ("Train", emissionsData[2]),
//                ("Bus", emissionsData[3])
//            ]))
//            .frame(height: CGFloat(200))
//            .foregroundColor(.barChartColor) // Custom color
//
//            HStack {
//                Text("Category")
//                    .frame(maxWidth: .infinity)
//                    .foregroundColor(.axisLabelColor) // Custom color
//                    .font(.callout)
//                Text("Emissions")
//                    .foregroundColor(.axisLabelColor) // Custom color
//                    .font(.callout)
//            }
//
//            ForEach(0..<emissionsData.count) { index in
//                HStack {
//                    Text(categories[index])
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(.labelTextColor) // Custom color
//                        .font(.callout)
//                    Text("\(emissionsData[index], specifier: "%.0f")")
//                        .foregroundColor(.labelTextColor) // Custom color
//                        .font(.callout)
//                }
//            }
//        }
//    }
//}
//
//struct TopEmissionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopEmissionsView()
//    }
//}
//
//extension Color {
//    static let chartTitleColor = Color("ChartTitleColor") // Replace with your desired color code
//    static let chartBackgroundColor = Color("ChartBackgroundColor") // Replace with your desired color code
//    static let barChartColor = Color("BarChartColor") // Replace with your desired color code
//    static let axisLabelColor = Color("AxisLabelColor") // Replace with your desired color code
//    static let labelTextColor = Color("LabelTextColor") // Replace with your desired color code
//}
