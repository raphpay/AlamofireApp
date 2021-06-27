//
//  FakeData.swift
//  AlamofireTestsTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation

class FakeData {
    static var appleURL: URL {
        return URL(string: "https://www.apple.com")!
    }
    
    static var apiURL: URL {
        return URL(string: "https://api.edamam.com/search?app_id=08b5ed9a&app_key=ad5b86fa2c4478bfc7c55184d216b14a&to=2&q=chicken")!
    }
    
    static var ingredients : [String] {
        return ["Rice", "chicken"]
    }
    
    static var dict : [String: Any] {
        let bundle  = Bundle(for: FakeData.self)
        let url     = bundle.url(forResource: "FakeData", withExtension: "json")!
        let data    = try! Data(contentsOf: url)
        
        let json    = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
        
        return json
    }
}
