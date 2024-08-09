import SwiftUI

struct RegisterBalanceView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var amount: Double = 0.0
    @State private var currency: String = "MAD"
    
    var body: some View {
        VStack {
            TextField("Amount", value: $amount, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Currency", selection: $currency) {
                Text("MAD").tag("MAD")
                Text("USD").tag("USD")
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Button(action: {
                appViewModel.addOrUpdateBalance(amount: amount, currency: currency)
            }) {
                Text("Save Balance")
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
