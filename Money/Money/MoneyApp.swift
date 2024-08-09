//
//  MoneyApp.swift
//  Money
//
//  Created by BENNANI MEZIANE MOHAMMMED on 1/8/2024.
//

import SwiftUI

@main
struct MoneyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
