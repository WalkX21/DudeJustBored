import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var showingAddBalance = false
    @State private var showingAddTransaction = false
    @State private var showingTransactionHistory = false

    var body: some View {
        VStack {
            Text("Welcome back, \(dataModel.currentUser?.username ?? "user")!")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Text("Balances:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                VStack {
                    Text("USD")
                    Text("\(dataModel.currentUser?.balanceUSD ?? 0, specifier: "%.2f")")
                        .foregroundColor(.blue)
                }
                VStack {
                    Text("MAD")
                    Text("\(dataModel.currentUser?.balanceMAD ?? 0, specifier: "%.2f")")
                        .foregroundColor(.blue)
                }
                VStack {
                    Text("EUR")
                    Text("\(dataModel.currentUser?.balanceEUR ?? 0, specifier: "%.2f")")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            Button(action: {
                showingAddBalance = true
            }) {
                Text("Register new balance")
                    .font(.title2)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingAddBalance) {
                AddBalanceView()
                    .environmentObject(dataModel)
            }
            HStack {
                Text("Transactions:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showingTransactionHistory = true
                }) {
                    Text("see full")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showingTransactionHistory) {
                    TransactionHistoryView()
                        .environmentObject(dataModel)
                }
            }
            List(dataModel.transactions.suffix(2).reversed()) { transaction in
                TransactionRowView(transaction: transaction)
            }
            .onAppear {
                dataModel.fetchTransactions()
            }
            Button(action: {
                showingAddTransaction = true
            }) {
                Text("Add Transaction")
                    .font(.title2)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingAddTransaction, onDismiss: {
                dataModel.fetchTransactions()
            }) {
                AddTransactionView()
                    .environmentObject(dataModel)
            }
            Spacer()
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DataModel())
    }
}
