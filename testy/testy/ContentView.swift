import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        NavigationView {
            if dataModel.currentUser == nil {
                LoginView()
            } else {
                DashboardView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
