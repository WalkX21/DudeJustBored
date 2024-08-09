import SwiftUI

@main
struct MoneyManagerApp: App {
    var body: some Scene {
        WindowGroup {
            let databaseManager = DatabaseManager()
            let appViewModel = AppViewModel(databaseManager: databaseManager)
            
            ContentView()
                .environmentObject(appViewModel)
        }
    }
}
