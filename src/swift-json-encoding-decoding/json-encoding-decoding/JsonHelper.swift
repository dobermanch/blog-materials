//
//  JsonHelper.swift
//  json-encoding-decoding
//
//  Created by Sergii on 6/15/22.
//

import Foundation

struct JsonHelper {
    static func toJson<T: Encodable>(_ data: T) -> String {
        do {
            let encodedData = try JSONEncoder().encode(data)
            let jsonString = String(data: encodedData, encoding: .utf8)
            return jsonString ?? ""
        }
        catch {
            return ""
        }
    }
    
    static func fromJson<T: Decodable>(_ data: String?) -> T? {
        do {
            if data != nil, let dataFromJsonString = data!.data(using: .utf8) {
                return try JSONDecoder().decode(T.self, from: dataFromJsonString)
            }
            
            return nil
        }
        catch {
            return nil
        }
    }
}
