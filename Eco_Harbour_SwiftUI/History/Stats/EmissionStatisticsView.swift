import SwiftUI
import Charts

struct EmissionStatisticsView: View {
    @StateObject private var historyViewModel = AppHistoryModel()
    @State private var selectedID: UUID?
    @State private var text = ""
    
    @State private var selectedOptionIndex = 0
    let timeRangeOptions = ["7D", "1Y"]
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MMM-YY"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Emission Statistics")
                    .font(.subheadline)
                    .padding()
                Spacer()
                TimeRangeSelector(options: timeRangeOptions, selectedOptionIndex: $selectedOptionIndex)
                    .padding(.horizontal)
                    .onTapGesture {
                        selectedOptionIndex = selectedOptionIndex == 0 ? 1 : 0
                    }
            }
            
            
            if let historyData = historyViewModel.historyData {
                
                
                if selectedOptionIndex == 0 {
                    Text("Displaying data for the last 7 days")
                    
                    
                    //Temp
                    Chart {
                        ForEach(historyData.documents.filter { document in
                            let dateString = document.key
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "d-MMM-yy"
                            guard let documentDate = dateFormatter.date(from: dateString) else { return false }
                            return Calendar.current.dateComponents([.day], from: documentDate, to: Date()).day ?? 0 <= 7
                        }.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                            if let userEmissions = documentData["user_emissions"] as? Double {
                                BarMark(
                                    x: .value("Document \(documentID)", documentID), // Adjust the label as needed
                                    y: .value("User Emissions", userEmissions),
                                    width: .fixed(14.0)
                                )
                                .clipShape(Rectangle())
                                .cornerRadius(20)
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 1),
                                        Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 0.3)
                                    ]),
                                                   startPoint: .top,
                                                   endPoint: .bottom)
                                )
                            }
                        }
                    }
                    .chartYAxis(.visible)
                    .chartXAxis(.visible)
                    .frame(maxWidth: .infinity)
                    
                    
                    
                }
                
                
                
                
                else if selectedOptionIndex == 1 {
                    Text("Displaying data for the last 1 Year")
                    
                    Chart {
                        ForEach(historyData.documents.sorted(by: { $0.key < $1.key }), id: \.key) { documentID, documentData in
                            if let userEmissions = documentData["user_emissions"] as? Double {
                                BarMark(
                                    x: .value("Document \(documentID)", documentID), // Adjust the label as needed
                                    y: .value("User Emissions", userEmissions),
                                    width: .fixed(14.0)
                                )
                                .clipShape(Rectangle())
                                .cornerRadius(20)
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 1),
                                        Color(red: 66/255, green: 152/255, blue: 13/255, opacity: 0.3)
                                    ]),
                                                   startPoint: .top,
                                                   endPoint: .bottom)
                                )
                            }
                        }
                    }
                    .chartYAxis(.visible)
                    .chartXAxis(.visible)
                    .frame(maxWidth: .infinity)
                }
                
                
                else {
                    ProgressView()
                }
                
                
                
                
                
            }
        }
        .frame(height: 300)
        .task {
            try? await historyViewModel.loadCurrentUser()
        }
    }
}




struct TimeRangeSelector: View {
    let options: [String]
    @Binding var selectedOptionIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<options.count) { index in
                Button(action: {
                    selectedOptionIndex = index
                }) {
                    Text(options[index])
                        .padding(10)
                        .background(selectedOptionIndex == index ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}














enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownPicker: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
    var options: [String]
    var maxWidth: CGFloat = 180
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                
                
                if state == .top && showDropdown {
                    OptionsView()
                }
                
                HStack {
                    Text(selection == nil ? "Select" : selection!)
                        .foregroundColor(selection != nil ? .black : .gray)
                    
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
                .padding(.horizontal, 15)
                .frame(width: 150, height: 40)
                .background(.white)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(.white)
            .cornerRadius(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray)
            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
            
        }
        .frame(width: 150, height: 30)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(width: 150, height: 40)
                .contentShape(.rect)
                .padding(.leading, 15)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}

#Preview {
    EmissionStatisticsView()
}
