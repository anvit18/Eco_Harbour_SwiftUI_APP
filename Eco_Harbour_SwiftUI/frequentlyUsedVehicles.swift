import SwiftUI

struct VehicleCategoryView: View {
    let category: String
    let imageNames: [String]

    @State private var selectedImages: Set<String> = []

    var body: some View {
        VStack {
            HStack {
                Text(category)
                    .foregroundColor(.black)
                    .background(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .font(.title2)
                    .padding(.bottom, 10)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(imageNames, id: \.self) { imageName in
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 75)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedImages.contains(imageName) ? Color.green : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        toggleImageSelection(imageName)
                                    }

                                Text(imageName)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }

    private func toggleImageSelection(_ imageName: String) {
        if selectedImages.contains(imageName) {
            selectedImages.remove(imageName)
        } else {
            selectedImages.insert(imageName)
        }
    }
}

struct frequentlyUsedVehicles: View {
    @State private var showingNextScreen = false

    let carImages = ["Private", "Cabs", "Carpool"]
    let busImages = ["Ordinary", "AC", "Deluxe"]
    let trainImages = ["Local Train", "Metro"]
    let autoImages = ["Pillion", "Sharing", "Magic"]

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Eco")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                Text("Harbour")
                    .font(.largeTitle)
                    .bold()
            }
            .padding(.bottom, 30)

            Text("Choose vehicles that you frequently use, you can select multiple vehicles.")
                .foregroundColor(.black)
                .background(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .font(.subheadline)
                .padding(.bottom, 20)

            VehicleCategoryView(category: "Cars :", imageNames: carImages)
            VehicleCategoryView(category: "Buses :", imageNames: busImages)
            VehicleCategoryView(category: "Trains :", imageNames: trainImages)
            VehicleCategoryView(category: "Autos :", imageNames: autoImages)

            Button("Next") {
                showingNextScreen.toggle()
            }
            .foregroundColor(.white)
            .frame(width: 201, height: 44)
            .background(Color.mainGreen)
            .cornerRadius(10)
            .padding(.top, 30)

            NavigationLink(destination: VehicleDetails(), isActive: $showingNextScreen) {
                EmptyView()
            }
        }
        .navigationBarTitle("Frequently Used Vehicles")
    }
}

struct frequentlyUsedVehicles_Previews: PreviewProvider {
    static var previews: some View {
        frequentlyUsedVehicles()
    }
}
