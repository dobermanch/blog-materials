//
//  ContentView.swift
//  communication-between-an-iOS-and-watchOS WatchKit Extension
//
//  Created by Sergii on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    private var syncObject = SyncService().getSyncObject(TestSyncDataSyncObject.Key)
    @State private var data: String = ""
    @State private var receivedData: [String] = []
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter some data", text: $data)
          
                Button("Send", action: {
                    syncObject.sync(TestSyncData(data: data))
                })
            }.padding()
            
            Text("Received from Phone")
                .padding()
                    
            ForEach(receivedData, id: \.self) { item in
                Text(item)
                    .padding()
            }
        }
        .onReceive(syncObject.publisher) { data in
            if let data = data.object as? TestSyncData {
                self.receivedData.append("\(Date().formatted(date: .omitted, time: .standard)) - \(data.data)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
