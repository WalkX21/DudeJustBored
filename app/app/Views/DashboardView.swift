import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var showingRegisterBalance = false
    @State private var showingRegisterTransaction = false
    
    var body: some View {
        VStack {
            Text("Welcome back, \(appViewModel.user?.name ?? "User")!")
                .font(.largeTitle)
                .padding()
            
            // Display all balances
            ForEach(appViewModel.userBalances) { balance in
                Text("\(balance.amount, specifier: "%.2f") \(balance.currency.rawValue.uppercased())")
                    .font(.title)
                    .padding()
            }
            
            Button(action: {
                showingRegisterBalance = true
            }) {
                Text("Register New Balance")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingRegisterBalance) {
                RegisterBalanceView()
                    .environmentObject(appViewModel)
            }
            
            Button(action: {
                showingRegisterTransaction = true
            }) {
                Text("Register New Transaction")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingRegisterTransaction) {
                RegisterTransactionView()
                    .environmentObject(appViewModel)
            }
            
            // Transaction History Section
            Text("Transaction History")
                .font(.headline)
                .padding()
            
            List(appViewModel.userTransactions) { transaction in
                HStack {
                    Text(transaction.description)
                    Spacer()
                    Text("\(transaction.amount, specifier: "%.2f") \(transaction.category.uppercased())")
                        .foregroundColor(transaction.type == .income ? .green : .red)
                }
            }
        }
        .padding()
    }
}
