import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        VStack {
            Text(transaction.description)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(transaction.date)
                .font(.title2)
                .foregroundColor(.gray)
            Text("\(transaction.amount, specifier: "%.2f") \(transaction.currency)")
                .font(.title)
                .foregroundColor(transaction.amount < 0 ? .red : .green)
            Spacer()
        }
        .padding()
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction: Transaction(id: 1, userId: 1, description: "Test", amount: 100, date: "2024-08-03", type: "Income", currency: "USD"))
    }
}
