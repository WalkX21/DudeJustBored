import SwiftUI

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var userViewModel = UserViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Sign Up") {
                userViewModel.addUser(username: username, email: email, password: password)
            }
            .padding()
        }
        .padding()
    }
}
