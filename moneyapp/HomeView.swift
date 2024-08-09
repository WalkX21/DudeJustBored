import SwiftUI
import Firebase

struct HomeView: View {
    @State private var user: User?
    @State private var balances: [String: Double] = ["USD": 0.0, "MAD": 0.0, "EUR": 0.0]
    @State private var transactions: [Transaction] = []

    var body: some View {
        VStack {
            Text("Welcome back, \(user?.email ?? "user")!")
                .font(.largeTitle)
                .padding()

            BalancesView(balances: balances)

            Button(action: {
                // Navigate to register new balance view
            }) {
                Text("Register new balance")
            }
            .padding()

            TransactionsView(transactions: transactions)

            Spacer()
        }
        .onAppear {
            fetchUserData()
        }
    }

    private func fetchUserData() {
        guard let currentUser = Auth.auth().currentUser else { return }
        self.user = currentUser

        let ref = Database.database().reference()
        ref.child("users").child(currentUser.uid).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                self.balances = data["balances"] as? [String: Double] ?? ["USD": 0.0, "MAD": 0.0, "EUR": 0.0]
                self.transactions = (data["transactions"] as? [[String: Any]])?.compactMap { Transaction(dict: $0) } ?? []
            }
        }
    }
}

struct BalancesView: View {
    var balances: [String: Double]

    var body: some View {
        HStack {
            ForEach(balances.keys.sorted(), id: \.self) { currency in
                VStack {
                    Text(currency)
                    Text("\(balances[currency] ?? 0.0)")
                }
                .padding()
            }
        }
    }
}

struct TransactionsView: View {
    var transactions: [Transaction]

    var body: some View {
        VStack {
            HStack {
                Text("Transactions:")
                Spacer()
                Button(action: {
                    // Navigate to register new transaction view
                }) {
                    Text("+")
                }
                .padding()
            }

            ForEach(transactions.prefix(2)) { transaction in
                HStack {
                    Text(transaction.description)
                    Spacer()
                    Text("\(transaction.amount, specifier: "%.2f") \(transaction.currency)")
                        .foregroundColor(transaction.amount < 0 ? .red : .green)
                }
                .padding()
            }

            Button(action: {
                // Navigate to see full transaction history
            }) {
                Text("See full")
            }
            .padding()
        }
    }
}
