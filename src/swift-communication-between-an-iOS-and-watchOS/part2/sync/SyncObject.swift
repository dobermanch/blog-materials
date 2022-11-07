//
//  SyncObject.swift
//  sync
//
//  Created by Sergii on 6/17/22.
//

import Foundation

protocol ISyncObject {
    var key: Notification.Name { get }
    var publisher: NotificationCenter.Publisher { get }
    
    func sync()
    func sync<T: Codable>(_ message: T)
    func received(_ message: Any)
}

class SyncObject<T: Codable>: ISyncObject {
    let service: SyncService
    private (set) var key: Notification.Name
    private (set) var publisher: NotificationCenter.Publisher
    
    var lastSyncTime: Date? {
        get { return UserDefaults.standard.value(forKey: "syncApp.\(key.rawValue).lastSyncTime") as? Date }
        set {
            UserDefaults.standard.set(newValue, forKey: "syncApp.\(key.rawValue).lastSyncTime")
            needSync = false
        }
    }
    
    var needSync: Bool {
        get { return UserDefaults.standard.value(forKey: "syncApp.\(key.rawValue).needSync") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "syncApp.\(key.rawValue).needSync") }
    }

    init(_ key: Notification.Name, service: SyncService) {
        self.key = key
        self.service = service
        self.publisher = NotificationCenter.default.publisher(for: key)
    }
     
    func sync() { }
    
    func sync<T: Codable>(_ message: T) {
        if !service.isReachable {
            needSync = true
            return
        }
        
        let data = JsonHelper.toJson(message)
        service.sendMessage(key.rawValue, data, { error in
            self.needSync = true
        })
        
        lastSyncTime = Date()
    
        print("[Sync:\(key.rawValue)] Sent data: \(data)")
    }
    
    func received(_ message: Any) {
        print("[Sync:\(key.rawValue)] Received data: \(message)")

        let data: T? = JsonHelper.fromJson(message as? String)
        if let data = data {
            received(data)
        }
    }
    
    internal func received(_ message: T) {
        publish(message)
    }
    
    internal func publish(_ message: T) {
        NotificationCenter.default.post(name: key, object: message)
    }
}
