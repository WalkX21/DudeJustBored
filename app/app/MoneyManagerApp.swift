import SwiftUI

@main
struct MoneyManagerApp: App {
    var body: some Scene {
        WindowGroup {
            // Create an instance of DatabaseManager
            let databaseManager = DatabaseManager()
            // Pass it to AppViewModel
            let appViewModel = AppViewModel(databaseManager: databaseManager)
            
            // Use the environment object to share it with the views
            ContentView()
                .environmentObject(appViewModel)
        }
    }
}
