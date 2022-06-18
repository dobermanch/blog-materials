//
//  ContentView.swift
//  communication-between-an-iOS-and-watchOS
//
//  Created by Sergii on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    private var syncService = SyncService()
    @State private var data: String = ""
    @State private var receivedData: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter some data", text: $data)

                Button("Send", action: {
                    syncService.sendMessage("dataToSync", data, { error in })
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
