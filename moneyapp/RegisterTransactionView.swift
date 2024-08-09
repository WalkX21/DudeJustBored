import SwiftUI
import Firebase

struct RegisterTransactionView: View {
    @State private var description: String = ""
    @State private var amount: Double = 0.0
    @State private var currency: String = "USD"

    var body: some View {
        VStack {
            TextField("Description", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Amount", value: $amount, format: .number)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Currency", text: $currency)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: registerTransaction) {
                Text("Register Transaction")
            }
            .padding()
        }
    }

    private func registerTransaction() {
        guard let currentUser = Auth.auth().currentUser else { return }

        let ref = Database.database().reference()
        let transactionRef = ref.child("users").child(currentUser.uid).child("transactions").childByAutoId()

        let transaction = Transaction(
            id: transactionRef.key ?? UUID().uuidString,
            description: description,
            amount: amount,
            currency: currency,
            date: Date()
        )

        transactionRef.setValue(transaction.toDict())
    }
}
