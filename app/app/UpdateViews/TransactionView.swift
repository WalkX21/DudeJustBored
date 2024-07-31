import SwiftUI

struct TransactionView: View {
    @StateObject private var transactionViewModel = TransactionViewModel()
    
    var body: some View {
        VStack {
            Picker("Type", selection: $transactionViewModel.type) {
                Text("Income").tag(TransactionType.income)
                Text("Expense").tag(TransactionType.expense)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("Amount", value: $transactionViewModel.amount, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            DatePicker("Date", selection: $transactionViewModel.date, displayedComponents: .date)
                .padding()
            
            Picker("Category", selection: $transactionViewModel.category) {
                ForEach(transactionViewModel.categories, id: \.self) { category in
                    Text("\(category.emoji) \(category.name)").tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            TextField("Description", text: $transactionViewModel.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                transactionViewModel.saveTransaction()
            }) {
                Text("Save Transaction")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            List(transactionViewModel.transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
        .padding()
    }
}
