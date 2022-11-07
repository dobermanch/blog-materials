//
//  syncApp.swift
//  sync WatchKit Extension
//
//  Created by Sergii on 6/17/22.
//

import SwiftUI

@main
struct syncApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
