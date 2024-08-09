import SwiftUI

@main
struct testyApp: App {
    @StateObject private var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
    }
}
