//
//  ContentView.swift
//  json-encoding-decoding
//
//  Created by Sergii on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var employee = Employee(id: UUID(), name: "John", lastName: "Doe")
    
    var body: some View {
        VStack {
            Text("My name is \(employee.name) \(employee.lastName)")
                .padding()
            
            Button("Change name", action: {
                var original = self.employee
                original.name = original.name == "John" ? "Jane" : "John"
                let json = JsonHelper.toJson(original)
                self.employee = JsonHelper.fromJson(json)!
            })
        }
    }
}

struct Employee: Codable {
    var id: UUID
    var name: String
    var lastName: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
