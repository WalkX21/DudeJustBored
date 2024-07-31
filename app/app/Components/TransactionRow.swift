import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Text(transaction.type == .income ? "+" : "-")
                .foregroundColor(transaction.type == .income ? .green : .red)
            
            VStack(alignment: .leading) {
                Text(transaction.category) // Use category directly
                    .font(.headline)
                
                Text(transaction.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(transaction.amount, specifier: "%.2f")")
        }
        .padding()
    }
}
