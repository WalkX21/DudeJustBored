import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Money app")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button(action: {
                if dataModel.authenticate(username: username, password: password) {
                    // Navigate to dashboard
                } else {
                    // Show error message
                }
            }) {
                Text("Connect")
                    .font(.title2)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
            HStack {
                Text("You don't have an account?")
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(DataModel())
    }
}
