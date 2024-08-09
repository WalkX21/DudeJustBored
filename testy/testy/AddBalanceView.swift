import SwiftUI

struct AddBalanceView: View {
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.presentationMode) var presentationMode
    @State private var amount: String = ""
    @State private var currency: String = "USD"

    var body: some View {
        VStack {
            Text("Add Balance")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Amount", text: $amount)
                .padding()
                .keyboardType(.decimalPad)
                .background(Color(.secondarySystemBackground))
            Picker("Currency", selection: $currency) {
                Text("USD").tag("USD")
                Text("MAD").tag("MAD")
                Text("EUR").tag("EUR")
            }
            .pickerStyle(SegmentedPickerStyle())
            Button(action: {
                if let amount = Double(amount) {
                    dataModel.updateBalance(amount: amount, currency: currency)
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

struct AddBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        AddBalanceView()
            .environmentObject(DataModel())
    }
}
