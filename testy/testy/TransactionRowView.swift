import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.headline)
                Text(transaction.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(transaction.amount < 0 ? "-" : "+")\(abs(transaction.amount), specifier: "%.2f") \(transaction.currency)")
                .foregroundColor(transaction.amount < 0 ? .red : .green)
                .font(.headline)
        }
        .padding()
        .background(transaction.amount < 0 ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction: Transaction(id: 1, userId: 1, description: "Cinema", amount: -200, date: "2024-08-02", type: "Expense", currency: "USD"))
    }
}
