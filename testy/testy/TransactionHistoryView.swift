import SwiftUI

struct TransactionHistoryView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            Text("Transaction History")
                .font(.largeTitle)
                .fontWeight(.bold)
            List {
                ForEach(dataModel.transactions.reversed()) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            }
        }
        .padding()
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
            .environmentObject(DataModel())
    }
}
