import SwiftUI

struct RegisterTransactionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var type: String = "Income"
    @State private var amount: Double = 0.0
    @State private var description: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            Picker("Type", selection: $type) {
                Text("Income").tag("Income")
                Text("Expense").tag("Expense")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("Amount", value: $amount, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Date", selection: $date)
                .padding()
            
            Button(action: {
                let dateString = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
                appViewModel.addTransaction(type: type, amount: amount, description: description, date: dateString)
            }) {
                Text("Save Transaction")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}
