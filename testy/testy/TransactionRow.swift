import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    @State private var showingDetails = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.description)
                    .font(.headline)
                Spacer()
                Text("\(transaction.amount, specifier: "%.2f") \(transaction.currency)")
                    .foregroundColor(transaction.type == "Expense" ? .red : .green)
                    .font(.headline)
            }
            .padding()
            .background(transaction.type == "Expense" ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
            .cornerRadius(10)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showingDetails.toggle()
        }
        .sheet(isPresented: $showingDetails) {
            TransactionDetailView(transaction: transaction)
        }
        .padding(.horizontal)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: Transaction(id: 1, userId: 1, description: "Cinema", amount: -200, date: "2024-08-02", type: "Expense", currency: "MAD"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
