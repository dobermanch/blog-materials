//
//  AppInfo.swift
//  App Basic Info
//
//  Created by Sergii on 6/13/22.
//

import SwiftUI

struct AppInfo {
    
    static var bundleIdentifier: String {
        return (Bundle.main.bundleIdentifier ?? "")
    }
    
    static var displayName: String {
        Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }
    
    static var appBuild: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
    
    static var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    static var appFullVersion: String {
        appVersion + "." + appBuild
    }
    
    static var watchOSVersion: String?
    
    static var watchModel: String?
    
    #if os(iOS)
    static var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    static var deviceModel: String {
        #if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
        //UIDevice.current.name
        return identifier
    }
    #endif
}
