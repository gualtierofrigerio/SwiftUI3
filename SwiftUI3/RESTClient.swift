//
//  RESTClient.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import Foundation

class RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
        task.resume()
    }
    
    func getData(atURL url: URL) async throws -> Data {
        let result = try await URLSession.shared.data(from: url, delegate: nil)
        return result.0
    }
}
