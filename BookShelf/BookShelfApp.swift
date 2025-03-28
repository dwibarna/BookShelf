//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Dwi Aji Sobarna on 28/03/25.
//

import SwiftUI

@main
struct BookShelfApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
