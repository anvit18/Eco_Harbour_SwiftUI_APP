import SwiftUI

struct CategoryView: View {
    let category: String
    let systemImage: String
    // car = ""
    @Binding var selectedCategory: String?

    var body: some View {
        
        
        Button(action: {
            selectedCategory = category
        }) {
            VStack {
                Image(systemName: systemImage)
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 40)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                Text(category)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .background(selectedCategory == category ? Color.green : Color.green.opacity(0.2))
            //.cornerRadius(10)
        }
        .frame(width: 100, height: 80)
        .cornerRadius(13)
    }
}

struct recordView: View {
//    Temp
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var distanceViewModel : DistanceViewModel
    
    
    @State private var privateDistance: Int = 0
        @State private var cabsDistance: Int = 0
        @State private var carpoolDistance: Int = 0
        @State private var localTrainDistance: Int = 0
        @State private var metroDistance: Int = 0
        @State private var pillionDistance: Int = 0
        @State private var sharingDistance: Int = 0
        @State private var magicDistance: Int = 0
        @State private var ordinaryDistance: Int = 0
        @State private var acDistance: Int = 0
        @State private var deluxeDistance: Int = 0
    
    // Emission Factor Variables, set dummy for now
      @State private var privateFactor: Double = 20
      @State private var cabsFactor: Double = 18
      @State private var carpoolFactor: Double = 16
      @State private var localTrainFactor: Double = 4
      @State private var metroFactor: Double = 8
      @State private var pillionFactor: Double = 13
      @State private var sharingFactor: Double = 7
      @State private var magicFactor: Double = 9
      @State private var ordinaryFactor: Double = 4
      @State private var acFactor: Double = 10
      @State private var deluxeFactor: Double = 5
    
    var userEmissions: Double {
            return (Double(privateDistance) * privateFactor) +
                   (Double(cabsDistance) * cabsFactor) +
                   (Double(carpoolDistance) * carpoolFactor) +
                   (Double(localTrainDistance) * localTrainFactor) +
                   (Double(metroDistance) * metroFactor) +
                   (Double(pillionDistance) * pillionFactor) +
                   (Double(sharingDistance) * sharingFactor) +
                   (Double(magicDistance) * magicFactor) +
                   (Double(ordinaryDistance) * ordinaryFactor) +
                   (Double(acDistance) * acFactor) +
                   (Double(deluxeDistance) * deluxeFactor)
        }
    
    @State private var selectedCategory: String?
    @State private var showStepper = false
    
    @State var carDistance: Int = 0
    @State var busDistance: Int = 0
    @State var trainDistance: Int = 0
    @State var carPoolDistance: Int = 0
    @State var autoDistance: Int = 0
    
    @State private var showAlert = false
    @State private var cityName = ""
    @State private var carType = ""
    @State private var busType = ""
    @State private var trainType = ""
    @State private var autoType = ""
    @State private var carPool = ""
    @State private var setDefault = false
    @State private var dummyVar = ""
    @State private var fuel = ""
    @State private var numberOfPassengers = ""
    @State private var showingNextScreen = false
    
    // New state variable to store the selected date
    @State private var selectedDate = Date()
    
    let categories = [
        Category(name: "Car", systemImage: "car"),
        Category(name: "Bus", systemImage: "bus"),
        Category(name: "Train", systemImage: "train.side.rear.car"),
        Category(name: "Car Pool", systemImage: "car.2.fill"),
        Category(name: "Auto", systemImage: "car.circle")
    ]
    
    struct Category {
        var name: String
        var systemImage: String
    }
    
    struct CategoryFields {
        var numberOfPassengers = ""
        var vehicleSize = ""
        var fuelType = ""
        var timeTravelled = ""
        var isACSwitchOn = false
    }
    
    @State private var category1Fields = CategoryFields()
    @State private var category2Fields = CategoryFields()
    @State private var category3Fields = CategoryFields()
    @State private var category4Fields = CategoryFields()
    @State private var category5Fields = CategoryFields()
    
    var body: some View {
        VStack {
            ScrollView {
                
                HStack {
                    
                    Text("Record Emissions")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                HStack {
                    
                    
                   // Spacer()
                    
                    Menu {
                        Button("Cancel", role: .destructive) {
                            // Do something
                        }
                        
                        Button {
                            // do something
                            cityName = "Chennai"
                        }label: {
                            Label("Chennai", systemImage:  "")
                        }
                        
                        Button {
                            // Do something
                            cityName = "Mumbai"
                        } label: {
                            Label("Mumbai", systemImage: "")
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Button {
                            // Do something
                            cityName = "Pune"
                        } label: {
                            Label("Pune", systemImage: "")
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    } label: {
                        TextField("Chennai", text: $cityName)
                            .padding()
                            .autocapitalization(.allCharacters)
                            .frame(width: 350, height: 40)
                            .background(Color.mainGreen.opacity(0.05))
                            .cornerRadius(10)
                    }
                    
                }.padding(.bottom,20)
                
                HStack{
                    // DatePicker to select the date
                    DatePicker("",
                               selection: $selectedDate,
                               in: ...Date(), // Restrict future dates
                               displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .frame(width: 200, height: 40)
                    //.padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.leading,-50)
                    .padding(.trailing,40)
                    
                    
                   Spacer()
                    Button("History", systemImage: "clock.fill") {
                        // Authenticate user
                        showingNextScreen.toggle()
                    }
                    .font(.title2)
                    .foregroundColor(.mainGreen)
                    .frame(width: 180, height: 40)
                    //.background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    //.padding(.leading,-40)
                   // .padding(.trailing,50)
                    
                    NavigationLink(destination: HistoryView(), isActive: $showingNextScreen) {
                                        EmptyView()
                                    }
                    
                    
                }
                
                Text("Select the modes of transport you used today")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                    .padding(.top,20)
                    .padding(.bottom,-10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(categories, id: \.name) { category in
                            CategoryView(category: category.name, systemImage: category.systemImage, selectedCategory: $selectedCategory)
                        }
                    }
                    .padding()
                }
                
                renderInputSection()
                    .padding()
            }
            .navigationBarTitle("Record Emissions")
        }
    }
    
    private func formattedCurrentDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE,\nMMM d, yyyy"
            return formatter.string(from: Date())
        }
    
    private func renderInputSection() -> some View {
        VStack {
            switch selectedCategory {
            case "Car": renderCategoryFields(fields: $category1Fields)
            case "Bus": renderCategoryFields(fields: $category2Fields)
            case "Train": renderCategoryFields(fields: $category3Fields)
            case "Car Pool": renderCategoryFields(fields: $category4Fields)
            case "Auto": renderCategoryFields(fields: $category5Fields)
            default: EmptyView()
            }

            Spacer()
            HStack {
                Button("Cancel") {
                    //showingNextScreen.toggle()
                }
                .foregroundColor(.mainGreen)
                .frame(width: 130, height: 38)
                .background(Color.mainGreen.opacity(0.09))
                .cornerRadius(10)
                .padding(.top, 30)
                .padding(.trailing, 40)

//                NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
//                    EmptyView()
//                }
                
                Button("Save") {
                                   // Add your logic for saving data or performing an action
                                   printUserInput()
                                   saveUserInput()

                                   // Show the alert
                                   showAlert = true
                               }
                               .foregroundColor(.white)
                               .frame(width: 130, height: 38)
                               .background(Color.mainGreen)
                               .cornerRadius(10)
                               .padding(.top, 30)
                               // Add the alert
                               .alert(isPresented: $showAlert) {
                                   Alert(
                                       title: Text("Data Logged Successfully!"),
                                       dismissButton: .default(Text("OK"))
                                   )
                               }

//                NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
//                    EmptyView()
//                }
                
                
            }
        }
    }

    private func renderCategoryFields(fields: Binding<CategoryFields>) -> some View {
        VStack(spacing: 0) {
            
            HStack{
                Text("Vehicle Type :")
                    .foregroundStyle(Color.mainGreen)
                    .padding(.leading, 30)
                    .padding(.bottom, 20)
                    .font(.subheadline)
                Spacer()
            }.padding(.bottom, -10)
            if selectedCategory == "Car" {
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        carType = "Private"
                    }label: {
                        Label("Private", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        carType = "Cab"
                    } label: {
                        Label("Cab", systemImage: "suv.side.fill")
                    }
                    
                } label: {
                    TextField("e.g. Cab" , text: $carType){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                
                HStack{
                    Text("Distance Travelled :")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                        
                    Spacer()
                }.padding(.bottom, -10)
                    
                    
                    
                
               
                    VStack {
                        Stepper(value: $carDistance, in: 0...100) {
                                                                    Text("\(carDistance) KMS")
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                            }.multilineTextAlignment(.leading)
                        .padding(.leading,20)
                       
                        .keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                                                        
                
                
                
                ZStack {
                    TextField("" , text: $dummyVar){ //fields.vehicleSize){
                        
                    }.multilineTextAlignment(.leading)
                        .padding()
                    //.keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("AC")
                        
                        
                        Spacer()
                        
                        Toggle("", isOn: fields.isACSwitchOn)
                            .labelsHidden()
                            .padding(.trailing, 50)
                    }.padding(.leading,  50)
                }
                .padding(.bottom, 20)
            }
            if selectedCategory == "Bus" {
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        busType = "Ordinary"
                    }label: {
                        Label("Ordinary", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        busType = "AC"
                    } label: {
                        Label("AC", systemImage: "suv.side.fill")
                    }
                    
                    Button {
                        // Do something
                        busType = "Deluxe"
                    } label: {
                        Label("Deluxe", systemImage: "truck.pickup.side.fill")
                    }
                } label: {
                    TextField("e.g. Ordinary" , text: $busType){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                HStack{
                    Text("Distance Travelled :")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                        
                    Spacer()
                }.padding(.bottom, -10)
                    
                    
                    
                
              
                    VStack {
                        Stepper(value: $busDistance, in: 0...100) {
                                                                    Text("\(busDistance) KMS")
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                            }.multilineTextAlignment(.leading)
                        .padding(.leading,20)
                       
                        .keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                                                        
                
                ZStack {
                    TextField("" , text: $dummyVar){ //fields.vehicleSize){
                        
                    }.multilineTextAlignment(.leading)
                        .padding()
                    //.keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("AC")
                        
                        
                        Spacer()
                        
                        Toggle("", isOn: fields.isACSwitchOn)
                            .labelsHidden()
                            .padding(.trailing, 50)
                    }.padding(.leading,  50)
                }
                .padding(.bottom, 20)
            }
            if selectedCategory == "Train" {
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        trainType = "Metro"
                    }label: {
                        Label("Metro", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        trainType = "Local"
                    } label: {
                        Label("Local", systemImage: "suv.side.fill")
                    }
                    
                } label: {
                    TextField("e.g. Local" , text: $trainType){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                
                HStack{
                    Text("Distance Travelled :")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                        
                    Spacer()
                }.padding(.bottom, -10)
                    
                    
                    
                
               
                    VStack {
                        Stepper(value: $trainDistance, in: 0...200, step:5) {
                                                                    Text("\(trainDistance) KMS")
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                            }.multilineTextAlignment(.leading)
                        .padding(.leading,20)
                       
                        .keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                                                
                
                ZStack {
                    TextField("" , text: $dummyVar){ //fields.vehicleSize){
                        
                    }.multilineTextAlignment(.leading)
                        .padding()
                    //.keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("AC")
                        
                        
                        Spacer()
                        
                        Toggle("", isOn: fields.isACSwitchOn)
                            .labelsHidden()
                            .padding(.trailing, 50)
                    }.padding(.leading,  50)
                }
                .padding(.bottom, 20)
            }
            
            if selectedCategory == "Auto" {
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        autoType = "Pillion"
                    }label: {
                        Label("Pillion", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        autoType = "Share"
                    } label: {
                        Label("Share", systemImage: "suv.side.fill")
                    }
                    Button {
                        // do something
                        autoType = "Magic"
                    }label: {
                        Label("Magic", systemImage:  "car.side.fill")
                    }
                    
                } label: {
                    TextField("e.g. Share" , text: $autoType){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                
                HStack{
                    Text("Distance Travelled :")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                        
                    Spacer()
                }.padding(.bottom, -10)
                    
                    
                    
                
               
                    VStack {
                        Stepper(value: $autoDistance, in: 0...100) {
                                                                    Text("\(autoDistance) KMS")
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                            }.multilineTextAlignment(.leading)
                        .padding(.leading,20)
                       
                        .keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                                                
                
                
                
                ZStack {
                    TextField("" , text: $dummyVar){ //fields.vehicleSize){
                        
                    }.multilineTextAlignment(.leading)
                        .padding()
                    //.keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("AC")
                        
                        
                        Spacer()
                        
                        Toggle("", isOn: fields.isACSwitchOn)
                            .labelsHidden()
                            .padding(.trailing, 50)
                    }.padding(.leading,  50)
                }
                .padding(.bottom, 20)
            }
           
            if selectedCategory == "Car Pool" {
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        carPool = "Car Pool"
                    }label: {
                        Label("Car Pool", systemImage:  "car.side.fill")
                    }
                    
                    
                } label: {
                    TextField("Car Pool" , text: $carPool){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                
                HStack{
                    Text("Distance Travelled :")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                        
                    Spacer()
                }.padding(.bottom, -10)
                    
                    
                    
                
               
                    VStack {
                        Stepper(value: $carPoolDistance, in: 0...100) {
                                                                    Text("\(carPoolDistance) KMS")
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                            }.multilineTextAlignment(.leading)
                        .padding(.leading,20)
                       
                        .keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                                                
                
                
                
                ZStack {
                    TextField("" , text: $dummyVar){ //fields.vehicleSize){
                        
                    }.multilineTextAlignment(.leading)
                        .padding()
                    //.keyboardType(.numberPad)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("AC")
                        
                        
                        Spacer()
                        
                        Toggle("", isOn: fields.isACSwitchOn)
                            .labelsHidden()
                            .padding(.trailing, 50)
                    }.padding(.leading,  50)
                }
                .padding(.bottom, 20)
                HStack{
                    Text("Number of Passengers")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                    Spacer()
                }.padding(.bottom, -10)
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    Button {
                        // do something
                        numberOfPassengers = "1"
                    }label: {
                        Label("1", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // do something
                        numberOfPassengers = "2"
                    }label: {
                        Label("2", systemImage:  "car.side.fill")
                    }
                    
                    
                    Button {
                        // do something
                        numberOfPassengers = "3"
                    }label: {
                        Label("3", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // do something
                        numberOfPassengers = "4"
                    }label: {
                        Label("4", systemImage:  "car.side.fill")
                    }
                    
                    Button {
                        // Do something
                        numberOfPassengers = "5"
                    } label: {
                        Label("5", systemImage: "suv.side.fill")
                    }
                    
                    Button {
                        // Do something
                        numberOfPassengers = "6"
                    } label: {
                        Label("6", systemImage: "truck.pickup.side.fill")
                    }
                } label: {
                    TextField("e.g. 4" , text: $numberOfPassengers){ //fields.vehicleSize){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
                
                HStack{
                    Text("Fuel Type")
                        .foregroundStyle(Color.mainGreen)
                        .padding(.leading, 30)
                        .padding(.bottom, 20)
                        .font(.subheadline)
                    Spacer()
                }.padding(.bottom, -10)
                
                Menu {
                    Button("Cancel", role: .destructive) {
                        // Do something
                    }
                    
                    Button {
                        // do something
                        fuel = "Petrol"
                    }label: {
                        Label("Petrol", systemImage:  "fuelpump")
                    }
                    
                    Button {
                        // Do something
                        fuel = "Diesel"
                    } label: {
                        Label("Diesel", systemImage: "fuelpump.fill")
                    }
                    
                    Button {
                        // Do something
                        fuel = "Electric"
                    } label: {
                        Label("Electric", systemImage: "leaf.arrow.circlepath")
                    }
                } label: {
                    TextField("e.g Petrol" , text: $fuel){
                        
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                }.padding(.bottom, 20)
            }
            
        
            }
            
        }
    private func printUserInput() {
        guard let selectedCategory = selectedCategory else {
            print("Selected Category is nil.")
            return
        }

        print("Selected Category for Record: \(selectedCategory)")
        print("Selected Date:\(selectedDate)")
        switch selectedCategory {
        case "Car":
            print("Car: \(carType)")
            print("Distance Travelled: \(carDistance)")
            print("AC Switch: \(category1Fields.isACSwitchOn)")
        case "Bus":
            // Handle Bus category input
            print("Bus: \(busType)")
            print("Distance Travelled: \(busDistance)")
            print("AC Switch: \(category1Fields.isACSwitchOn)")
            break
        case "Train":
            // Handle Train category input
            print("Train: \(trainType)")
            print("Distance Travelled: \(trainDistance)")
            print("AC Switch: \(category1Fields.isACSwitchOn)")
            break
        case "Car Pool":
            print("Car Type: \(carPool)")
            print("Distance Travelled: \(carPoolDistance)")
            print("AC Switch: \(category4Fields.isACSwitchOn)")
            print("Number of Passengers: \(numberOfPassengers)")
            print("Fuel Type: \(fuel)")
        case "Auto":
            print("Auto Type: \(autoType)")
            print("Distance Travelled: \(autoDistance)")
            print("AC Switch: \(category4Fields.isACSwitchOn)")
        default:
            break
        }
    }
    
    
    
    
    private func saveUserInput() {
        // Check if category is car
        if selectedCategory == "Car" {
            // Check car type
            switch carType {
            case "Private":
                privateDistance = carDistance
            case "Cab":
                cabsDistance = carDistance
            default:
                break
            }
        }
        
        //Check if category is carpool
        if selectedCategory=="Car Pool"{
            carpoolDistance = carPoolDistance
        }
        
        // Check if category is train
        if selectedCategory == "Train" {
            // Check train type
            switch trainType {
            case "Local":
                localTrainDistance = trainDistance
            case "Metro":
                metroDistance = trainDistance
            default:
                // Handle other train types
                break
            }
        }
        
        if selectedCategory == "Auto" {
            // Check train type
            switch autoType {
            case "Pillion":
                pillionDistance = autoDistance
            case "Sharing":
                sharingDistance = autoDistance
            case "Magic":
                magicDistance = autoDistance
            default:
                // Handle other train types
                break
            }
        }
        if selectedCategory == "Bus" {
            // Check train type
            switch busType {
            case "Ordinary":
                print("Ordinary selected!!!!!!")
            case "AC":
                acDistance = busDistance
            case "Deluxe":
                deluxeDistance = busDistance
            default:
                // Handle other train types
                break
            }
        }
        
        // Add similar logic for other categories and vehicle types
        
        // Print updated distances (optional)
        print("car Distance: \(carDistance)")
        print("car pool Distance: \(carPoolDistance)")
        print("bus Distance: \(busDistance)")
        print("auto Distance: \(autoDistance)")
        print("train Distance: \(trainDistance)")
        // Print other distances as needed
        
        
        
        userData.userEmission = userEmissions
        userData.datePicked = selectedDate
        distanceViewModel.privateVDistance = privateDistance
        distanceViewModel.cabsVDistance = cabsDistance
        distanceViewModel.carpoolVDistance = carpoolDistance
        distanceViewModel.localTrainVDistance = localTrainDistance
        distanceViewModel.metroVDistance = metroDistance
        distanceViewModel.pillionVDistance = pillionDistance
        distanceViewModel.sharingVDistance = sharingDistance
        distanceViewModel.magicVDistance = magicDistance
        distanceViewModel.ordinaryVDistance = ordinaryDistance
        distanceViewModel.acVDistance = acDistance
        distanceViewModel.deluxeVDistance = deluxeDistance
    }
    
    
    

    }





struct recordView_Previews: PreviewProvider {
    static var previews: some View {
        recordView()
    }
}
