import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
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
                if name.isEmpty || email.isEmpty || password.isEmpty {
                    appViewModel.errorMessage = "All fields are required."
                } else {
                    appViewModel.signUp(name: name, email: email, password: password)
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign Up")
        .fullScreenCover(isPresented: $appViewModel.isLoggedIn) {
            DashboardView()
                .environmentObject(appViewModel)
        }
    }
}
