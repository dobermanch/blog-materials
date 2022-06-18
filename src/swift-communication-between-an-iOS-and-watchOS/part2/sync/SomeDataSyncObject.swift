//
//  TestSyncDataSyncObject.swift
//  sync
//
//  Created by Sergii on 6/17/22.
//

import Foundation

class SomeDataSyncObject: SyncObject<SomeData> {
    static let Key = Notification.Name("someData")
    
    init(_ service: SyncService) {
        super.init(SomeDataSyncObject.Key, service: service)
    }
    
    override func sync() {
        // custom sync logic
        // sync(SomeData(data: ....))
    }
    
    override func received(_ message: SomeData) {
        //here you can update DB, update app state, etc.
        super.received(message)
    }
}

struct SomeData: Codable  {
    var data: String
}
