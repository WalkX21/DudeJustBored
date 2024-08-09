import SwiftUI
import Firebase

struct RegisterBalanceView: View {
    @State private var amount: Double = 0.0
    @State private var currency: String = "USD"

    var body: some View {
        VStack {
            TextField("Amount", value: $amount, format: .number)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Currency", text: $currency)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: registerBalance) {
                Text("Register Balance")
            }
            .padding()
        }
    }

    private func registerBalance() {
        guard let currentUser = Auth.auth().currentUser else { return }

        let ref = Database.database().reference()
        let balanceRef = ref.child("users").child(currentUser.uid).child("balances").child(currency)

        balanceRef.setValue(amount)
    }
}
