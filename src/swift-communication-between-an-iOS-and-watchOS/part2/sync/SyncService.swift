//
//  SyncService.swift
//  communication-between-an-iOS-and-watchOS
//
//  Created by Sergii on 6/17/22.
//

import Foundation
import WatchConnectivity
import Combine

class SyncService : NSObject, WCSessionDelegate {
    private var syncObjects: [ISyncObject] = []

    var session: WCSession = .default
    
    init(session: WCSession = .default) {
        self.session = session

        super.init()
        
        self.syncObjects = [
            SomeDataSyncObject(self)
        ]
        
        self.session.delegate = self
        self.connect()
    }
    
    func getSyncObject(_ key: Notification.Name) -> ISyncObject {
        return syncObjects.first { it in it.key == key }!
    }
    
     var isReachable: Bool {
        return session.isReachable
    }
    
    func connect(){
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }
        
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
    #endif

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            for msg in message {
                self.getSyncObject(Notification.Name(rawValue: msg.key)).received(msg.value)
            }
        }
    }

    func sendMessage(_ key: String, _ message: String, _ errorHandler: ((Error) -> Void)?) {
        if session.isReachable {
            session.sendMessage([key : message], replyHandler: nil) { (error) in
                print(error.localizedDescription)
                if let errorHandler = errorHandler {
                    errorHandler(error)
                }
            }
        }
    }
}
