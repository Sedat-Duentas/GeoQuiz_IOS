//
//  GeoQuizAppApp.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 28.08.23.
//

import SwiftUI

@main
struct GeoQuizAppApp: App {
    let persistenstore = PersistentStore.shared
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenstore.context)
        }
    }
}
