//
//  ContentView.swift
//  App Basic Info
//
//  Created by Sergii on 6/13/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Full Version: \(AppInfo.appFullVersion)")
            Text("Version: \(AppInfo.appVersion)")
            Text("Build: \(AppInfo.appBuild)")
            Text("Bundle Indentifier: \(AppInfo.bundleIdentifier)")
            Text("Device Model: \(AppInfo.deviceModel)")
            Text("System Version: \(AppInfo.systemVersion)")
            Text("App Dispaly Name: \(AppInfo.displayName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
