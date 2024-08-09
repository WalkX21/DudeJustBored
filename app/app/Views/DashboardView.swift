import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(appViewModel.userBalances) { balance in
                    HStack {
                        Text(balance.currency)
                        Spacer()
                        Text("\(balance.amount, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}
