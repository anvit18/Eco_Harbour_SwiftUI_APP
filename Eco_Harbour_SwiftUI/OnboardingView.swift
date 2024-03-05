// OnboardingView.swift

import SwiftUI

struct OnboardingView: View {
    // Images for onboarding
    let onboardingImages = ["onboard1 1", "onboard2 1"]

    // State variables to track the current image index and whether to show the next screen
    @State private var currentImageIndex = 0
    @State private var showingNextScreen = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                // Navigation Bar
                 // Hide the actual link, as it's triggered programmatically
                Spacer()
                // Swipeable Image
                Image(onboardingImages[currentImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 600)
                    .clipped()
                //.border(Color.black)
                //.cornerRadius(8)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                // Determine swipe direction based on gesture
                                let horizontalMovement = gesture.translation.width
                                if horizontalMovement < -50 {
                                    // Swipe left, move to the next image
                                    moveToNextImage()
                                } else if horizontalMovement > 50 {
                                    // Swipe right, move to the previous image
                                    moveToPreviousImage()
                                }
                            }
                    )
                
                // Page Indicator
                PageControl(numberOfPages: onboardingImages.count, currentPage: $currentImageIndex)
                    .padding(.top, -60)
                    .padding(.bottom, 20)
                
                Button("Skip") {
                    //authenticate user
                    showingNextScreen.toggle()
                    
                }
                .foregroundColor(.blue)
                .frame(width:201, height:44)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, -60)
                
                NavigationLink(destination: Login_Signup_Page(), isActive: $showingNextScreen){
                    EmptyView()
                }
                
                
                .navigationBarHidden(true)
            }
        }
    }

    // Function to move to the next image
    private func moveToNextImage() {
        if currentImageIndex < onboardingImages.count - 1 {
            currentImageIndex += 1
        } else {
            // If it's the last image, trigger the next screen
            showingNextScreen.toggle()
        }
    }

    // Function to move to the previous image
    private func moveToPreviousImage() {
        if currentImageIndex > 0 {
            currentImageIndex -= 1
        }
    }
}

//struct NextScreenView: View {
//    var body: some View {
//        Text("Next Screen")
//    }
//}

// PageControl to show the current page in the onboarding
struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(page == currentPage ? Color.blue : Color.gray)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
