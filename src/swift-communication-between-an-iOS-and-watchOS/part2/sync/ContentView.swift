//
//  ContentView.swift
//  communication-between-an-iOS-and-watchOS
//
//  Created by Sergii on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    private var syncObject = SyncService().getSyncObject(SomeDataSyncObject.Key)
    @State private var data: String = ""
    @State private var receivedData: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter some data", text: $data)

                Button("Send", action: {
                    syncObject.sync(SomeData(data: data))
                })
            }.padding()
            
            Text("Received from Watch")
                .padding()
                    
            ScrollView {
                ForEach(receivedData, id: \.self) { item in
                    Text(item)
                        .padding()
                }
            }
        }
        .onReceive(syncObject.publisher) { data in
            if let data = data.object as? SomeData {
                self.receivedData.append("\(Date().formatted(date: .omitted, time: .standard)) - \(data.data)")
            }
        }
    }}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
