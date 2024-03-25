
import SwiftUI


struct SignUpEmailView: View {
    
    @StateObject private var viewModel=SignUpEmailViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        
        ZStack{
            Color.mainGreen.ignoresSafeArea()
            
                
            Circle()
                .scale(1.9)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.7)
                .foregroundColor(.white)
            
            
            
            VStack{
                
                HStack(spacing: 0){
                    Text("Eco").font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                    Text("Track")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    
                }
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email....", text: $viewModel.email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.gray)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                SecureField("Password....", text: $viewModel.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.gray)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Button{
                    Task{
                        
                        // For sign up
                        do{
                            try await viewModel.signUp()
                            showSignInView=false
                            return
                        }catch{
                            print("error \(error)")
                        }
                    }
                    
                    
                } label:{
                    Text("Sign up")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.mainGreen)
                        .cornerRadius(10)
                }
                
                HStack{
                    Spacer()
                    NavigationLink{
                        SignInEmailView(showSignInView: $showSignInView)
                    } label:{
                        Text("Already a User? Log In")
                            .foregroundColor(.blue)
                            .background(.white)
                            .padding(.horizontal, 40)
                            .font(.callout)
                            .frame(alignment: .trailing)
                            .padding(.trailing, 8)
                    }
                    
                    
                }
                
                Spacer()
            }.padding(.top,170)
            
            
        }
    }
    
}

#Preview {
    SignUpEmailView(showSignInView: .constant(false))
}
