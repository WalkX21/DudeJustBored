import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if appViewModel.isLoggedIn {
                    DashboardView() // Show the DashboardView if logged in
                        .environmentObject(appViewModel)
                } else {
                    LoginView() // Show the LoginView if not logged in
                        .environmentObject(appViewModel)
                }
            }
        }
    }
}
