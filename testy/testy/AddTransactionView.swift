import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.presentationMode) var presentationMode
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var date = Date()
    @State private var type: String = "Expense"
    @State private var currency: String = "USD"

    var body: some View {
        VStack {
            Text("Add Transaction")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Description", text: $description)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Amount", text: $amount)
                .padding()
                .keyboardType(.decimalPad)
                .background(Color(.secondarySystemBackground))
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Picker("Type", selection: $type) {
                Text("Expense").tag("Expense")
                Text("Income").tag("Income")
            }
            .pickerStyle(SegmentedPickerStyle())
            Picker("Currency", selection: $currency) {
                Text("USD").tag("USD")
                Text("MAD").tag("MAD")
                Text("EUR").tag("EUR")
            }
            .pickerStyle(SegmentedPickerStyle())
            Button(action: {
                if let amount = Double(amount) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateString = dateFormatter.string(from: date)
                    dataModel.addTransaction(description: description, amount: type == "Expense" ? -amount : amount, date: dateString, type: type, currency: currency)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Add")
                    .font(.title2)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
            .environmentObject(DataModel())
    }
}
