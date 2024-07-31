import SwiftUI

struct RegisterTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State private var transactionType: TransactionType = .expense
    @State private var amount: Double = 0
    @State private var description: String = ""
    @State private var selectedCurrency: Currency = .mad // Default currency

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    Picker("Type", selection: $transactionType) {
                        Text("Income").tag(TransactionType.income)
                        Text("Expense").tag(TransactionType.expense)
                    }
                    
                    TextField("Amount", value: $amount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    
                    TextField("Description", text: $description)
                    
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach([Currency.usd, Currency.eur, Currency.mad], id: \.self) { currency in
                            Text(currency.rawValue.uppercased()).tag(currency)
                        }
                    }
                }
                
                Button(action: {
                    if transactionType == .income {
                        appViewModel.addTransaction(type: transactionType, amount: amount, description: description, category: selectedCurrency.rawValue)
                        appViewModel.addOrUpdateBalance(amount: amount, currency: selectedCurrency) // Update balance for income
                    } else {
                        appViewModel.addTransaction(type: transactionType, amount: -amount, description: description, category: selectedCurrency.rawValue) // Subtract for expenses
                        appViewModel.addOrUpdateBalance(amount: -amount, currency: selectedCurrency) // Update balance for expense
                    }
                    presentationMode.wrappedValue.dismiss() // Close the modal
                }) {
                    Text("Save Transaction")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Register Transaction")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
