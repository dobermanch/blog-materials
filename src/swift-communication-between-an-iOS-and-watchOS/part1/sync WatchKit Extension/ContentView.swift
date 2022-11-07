//
//  ContentView.swift
//  communication-between-an-iOS-and-watchOS WatchKit Extension
//
//  Created by Sergii on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    private var syncService = SyncService()
    @State private var data: String = ""
    @State private var receivedData: [String] = []
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter some data", text: $data)
          
                Button("Send", action: {
                    syncService.sendMessage("dataToSync", data, { error in })
                })
            }.padding()
            
            Text("Received from Phone")
                .padding()
                    
            ForEach(receivedData, id: \.self) { item in
                Text(item)
                    .padding()
            }
        }
        .onAppear { syncService.dataReceived = Receive }
    }
    
    private func Receive(key: String, value: Any) -> Void {
        self.receivedData.append("\(Date().formatted(date: .omitted, time: .standard)) - \(key):\(value)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
