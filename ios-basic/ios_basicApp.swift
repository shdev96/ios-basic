//
//  ios_basicApp.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import SwiftUI

@main
struct ios_basicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
