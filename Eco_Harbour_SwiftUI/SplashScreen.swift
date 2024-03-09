import SwiftUI

struct SplashScreen: View {
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    @State private var showLaunchScreen = false

    var body: some View {
        ZStack {
            Color.mainGreen.ignoresSafeArea()

            VStack {
                // Add your app logo or any content you want to display on the splash screen
                HStack(spacing: 0) {
                    Text("Ec")
                        .font(.system(size: 60, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.leading, 20)

                    Text("Track")
                        .foregroundStyle(Color.green)
                        .font(.system(size: 60, weight: .bold, design: .default))
                }
            }
            .offset(y: offsetY)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    // Rise-up animation
                    offsetY = 0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    // Set showLaunchScreen to true after the animation is complete
                    showLaunchScreen.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $showLaunchScreen, content: {
            LaunchScreen()
        })
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
