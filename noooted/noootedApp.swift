//
//  noootedApp.swift
//  noooted
//
//  Created by Adam Pagels on 2024-01-03.
//

import SwiftUI

@main
struct noootedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
        }
    }
}
