import SwiftUI

struct privateVehicleDetails: View {
    @State private var isShowingDialog = false
    @State private var vehicleNumber = ""
    @State private var showingNextScreen = false
    @State private var showingFillManually = false
    @State private var showingWhyWeAsk = false
    @State private var isFirstVisit = true // Add a state variable to track the first visit

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
            .padding(.bottom, 50)

            // Your main content here

            HStack {
                Text("Enter License Plate Number :")
                    .offset(x: -30)
                    .foregroundColor(.black)
                    .background(.white)
                    .padding(.horizontal, 60)
                    .font(.headline)
                    .frame(alignment: .trailing)
            }

            TextField("e.g. MH 11 CG 6199", text: $vehicleNumber)
                .padding()
                .autocapitalization(.allCharacters)
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)

            HStack {
                Spacer()
                Button("Why we ask for this ?") {
                    //add code
                    showingWhyWeAsk.toggle()
                }
                .foregroundColor(.mainGreen)
                .underline(true, color: .mainGreen)
                .background(.white)
                .padding(.horizontal, 40)
                .font(.callout)
                .frame(alignment: .trailing)
                .padding(.trailing, 8)

                NavigationLink(destination: SecondView(), isActive: $showingWhyWeAsk) {
                    EmptyView()
                }
            }

            Text("------------ or ------------")
                .font(.footnote)
                .foregroundColor(Color.gray)
                .padding(.top, 20)
                .padding(.bottom, 30)

            Text("Not comfortable sharing License Plate number ? You can input all the details manually instead of us fetching it from your license plate number.")
                .foregroundColor(.black)
                .background(.white)
                .padding(.horizontal, 60)
                .font(.caption)
                .padding(.bottom, 10)

            Button("Fill Manually ") {
                showingFillManually.toggle()
            }
            .foregroundColor(.blue)
            .background(.white)
            .underline()
            .padding(.horizontal, 30)
            .font(.title2)

            NavigationLink(destination: manualFilling(), isActive: $showingFillManually) {
                EmptyView()
            }

            Button("Next") {
                showingNextScreen.toggle()
            }
            .foregroundColor(.white)
            .frame(width: 201, height: 44)
            .background(Color.mainGreen)
            .cornerRadius(10)
            .padding(.top, 30)

            NavigationLink(destination: frequentlyUsedVehicles(), isActive: $showingNextScreen) {
                EmptyView()
            }
        }
        .navigationBarTitle("Private Vehicle Details")
        // Use .onAppear to trigger the dialog only on the first visit
        .onAppear {
            if isFirstVisit {
                isShowingDialog = true
                isFirstVisit = false
            }
        }
        // Present the dialog when isShowingDialog is true
        .alert(isPresented: $isShowingDialog) {
            Alert(
                title: Text("Let's Start Analysis!"),
                message: Text("Enter your private vehicle details for personalized testing!"),
                dismissButton: .default(Text("Close"))
            )
        }
    }
}

struct privateVehicleDetails_Previews: PreviewProvider {
    static var previews: some View {
        privateVehicleDetails()
    }
}
