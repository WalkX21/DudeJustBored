import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button(action: {
                dataModel.createUser(username: username, password: password)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Sign up")
                    .font(.title2)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(DataModel())
    }
}
