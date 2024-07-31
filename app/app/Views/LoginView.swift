import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if !appViewModel.errorMessage.isEmpty {
                    Text(appViewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    if email.isEmpty || password.isEmpty {
                        appViewModel.errorMessage = "Email and password cannot be empty."
                    } else {
                        appViewModel.login(email: email, password: password)
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationTitle("Login")
            .fullScreenCover(isPresented: $appViewModel.isLoggedIn) {
                DashboardView()
                    .environmentObject(appViewModel)
            }
        }
    }
}
