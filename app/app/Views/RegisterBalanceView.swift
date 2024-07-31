import SwiftUI

struct RegisterBalanceView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cashMAD: Double = 0
    @State private var cardMAD: Double = 0
    @State private var selectedCurrency: Currency = .mad // Default currency

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Currency")) {
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach([Currency.usd, Currency.eur, Currency.mad], id: \.self) { currency in
                            Text(currency.rawValue.uppercased()).tag(currency)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter Your Balances")) {
                    if selectedCurrency == .mad {
                        TextField("Cash", value: $cashMAD, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                        TextField("Card", value: $cardMAD, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Amount", value: $cashMAD, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button(action: {
                    let totalBalance = selectedCurrency == .mad ? (cashMAD + cardMAD) : cashMAD
                    appViewModel.addOrUpdateBalance(amount: totalBalance, currency: selectedCurrency)
                    presentationMode.wrappedValue.dismiss() // Close the modal
                }) {
                    Text("Save Balances")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Register Balance")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss() // Close the modal
            })
        }
    }
}
