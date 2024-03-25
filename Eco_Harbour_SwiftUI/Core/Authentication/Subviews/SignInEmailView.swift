import SwiftUI


struct SignInEmailView: View {
    
    @StateObject private var viewModel=SignInEmailViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        
        ZStack{
            Color.mainGreen.ignoresSafeArea()
            
            Circle()
                .scale(1.8)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.5)
                .foregroundColor(.white)
            
            VStack{
                
                HStack{
                    Text("Eco").font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                    Text("Track")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .bold()
                    
                }
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email....", text: $viewModel.email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.primary)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                
                SecureField("Password....", text: $viewModel.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.primary)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                
                Button{
                    Task{
                        
                        //for sign in
                        do{
                            try await viewModel.signIn()
                            showSignInView=false
                            return
                        }catch{
                            print("error \(error)")
                        }
                    }
                    
                    
                } label:{
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.mainGreen)
                        .cornerRadius(10)
                }
                
                HStack{
                    Spacer()
                    NavigationLink{
                        SignUpEmailView(showSignInView: $showSignInView)
                    } label:{
                        Text("New User? Sign Up")
                            .foregroundColor(.blue)
                            .background(.white)
                            .padding(.horizontal, 40)
                            .font(.callout)
                            .frame(alignment: .trailing)
                            .padding(.trailing, 8)
                    }
                    
                    
                }
                
                
                Spacer()
            }
            .padding(.top,170)
            
        }

    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
