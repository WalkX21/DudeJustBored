import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isAuthenticated = false
    @State private var showSignIn = false

    var body: some View {
        if isAuthenticated {
            HomeView()
        } else {
            VStack {
                Button(action: {
                    signIn()
                }) {
                    Text("Connect")
                }
                .padding()
                
                Button(action: {
                    showSignIn.toggle()
                }) {
                    Text("You don't have an account, sign in")
                }
                .padding()
                .sheet(isPresented: $showSignIn) {
                    SignUpView(isAuthenticated: $isAuthenticated)
                }
            }
        }
    }
    
    private func signIn() {
        // Replace with your actual logic
        Auth.auth().signIn(withEmail: "user@example.com", password: "password") { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                isAuthenticated = true
            }
        }
    }
}

struct SignUpView: View {
    @Binding var isAuthenticated: Bool
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: signUp) {
                Text("Sign Up")
            }
            .padding()
        }
    }

    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                isAuthenticated = true
            }
        }
    }
}
