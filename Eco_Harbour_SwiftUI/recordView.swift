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
    @State private var selectedCategory: String?
    
    @State private var car = ""
    @State private var time = ""
    @State private var setDefault = false
    @State private var dummyVar = ""
    @State private var fuel = ""
    @State private var numberOfPassengers = ""

    let categories = [
        Category(name: "Car", systemImage: "car"),
        Category(name: "Bus", systemImage: "bus"),
        Category(name: "Train", systemImage: "train.side.rear.car"),
        Category(name: "Car Pool", systemImage: "car.2.fill")
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
                
                HStack{
                    Text(formattedCurrentDate())
                        .font(.title2)
                        .foregroundColor(.mainGreen.opacity(0.8))
                        .bold()
                        .padding()
                        .underline()
                    
                    
                    Spacer()
                    
                    HStack {
                        
                        Toggle("Set Default", isOn: $setDefault)
                        //.labelsHidden()
                            .padding(.trailing, 20)
                    }.padding(.leading,  50)
                    
                }
                
                Text("Select the modes of transport you used today")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
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
                    //showingNextScreen.toggle()
                }
                .foregroundColor(.white)
                .frame(width: 130, height: 38)
                .background(Color.mainGreen)
                .cornerRadius(10)
                .padding(.top, 30)

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
            
            Menu {
                Button("Cancel", role: .destructive) {
                    // Do something
                }
                
                Button {
                    // do something
                    car = "Small"
                }label: {
                    Label("Small (1-3)", systemImage:  "car.side.fill")
                }
                
                Button {
                    // Do something
                    car = "Medium"
                } label: {
                    Label("Medium (3-5)", systemImage: "suv.side.fill")
                }
                
                Button {
                    // Do something
                    car = "Large"
                } label: {
                    Label("Large (5+)", systemImage: "truck.pickup.side.fill")
                }
            } label: {
                TextField("e.g. Large" , text: $car){ //fields.vehicleSize){
                    
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
                Text("Time Travelled")
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
                    time = "30mins"
                }label: {
                    Label("30 Mins", systemImage:  "car.side.fill")
                }
                
                Button {
                    // Do something
                    time = "1hr"
                } label: {
                    Label("1 Hr", systemImage: "suv.side.fill")
                }
                
                Button {
                    // Do something
                    time = "2hr"
                } label: {
                    Label("2 Hrs", systemImage: "truck.pickup.side.fill")
                }
            } label: {
                TextField("e.g. 4" , text: $time){ //fields.vehicleSize){
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.leading,20)
                .keyboardType(.numberPad)
                .frame(width: 300, height: 50)
                .foregroundColor(Color.black)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            }.padding(.bottom, 20)
            
            
            
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
            
            
            
            
            
            
            if selectedCategory == "Car Pool" {
                
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
                //end of car type menu
            }
            
        }
    }
}

struct recordView_Previews: PreviewProvider {
    static var previews: some View {
        recordView()
    }
}
