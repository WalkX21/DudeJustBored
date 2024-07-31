import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var appViewModel: AppViewModel // Use EnvironmentObject to access AppViewModel
    @State private var showingRegisterTransaction = false
    
    var body: some View {
        VStack {
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
                    .environmentObject(appViewModel) // Pass the environment object
            }
            
            List(appViewModel.userTransactions) { transaction in // Access transactions directly
                TransactionRow(transaction: transaction)
            }
        }
        .padding()
    }
}
