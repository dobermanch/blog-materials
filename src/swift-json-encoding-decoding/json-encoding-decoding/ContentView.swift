//
//  ContentView.swift
//  json-encoding-decoding
//
//  Created by Sergii on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var employee = Employee(id: UUID(), firstName: "John", lastName: "Doe")
    
    var body: some View {
        VStack {
            Text("My name is \(employee.firstName) \(employee.lastName)")
                .padding()
            
            Button("Change name", action: {
                var original = self.employee
                original.firstName = original.firstName == "John" ? "Jane" : "John"
                let json = JsonHelper.toJson(original)
                self.employee = JsonHelper.fromJson(json)!
            })
        }
    }
}

struct Employee: Codable {
    var id: UUID
    var firstName: String
    var lastName: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
