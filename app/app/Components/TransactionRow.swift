import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Text(transaction.type) // Assuming type is a String
            Spacer()
            Text("\(transaction.amount, specifier: "%.2f")")
            Spacer()
            Text(transaction.description)
            Spacer()
            Text(transaction.date) // Assuming date is a String
        }
    }
}
