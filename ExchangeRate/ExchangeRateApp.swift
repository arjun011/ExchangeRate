//
//  ExchangeRateApp.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI

@main
struct ExchangeRateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LiveRateView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
