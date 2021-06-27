//
//  FakeAlamofireService.swift
//  AlamofireTestsTests
//
//  Created by Raphaël Payet on 27/06/2021.
//

import Foundation
@testable import AlamofireTests

class FakeAlamofireService : NetworkRequest {
    var value: [String: Any]?
    var response: HTTPURLResponse?
    var error: Error?
    
    func getRecipes(with ingredients: [String], completion: @escaping ([Recipe]?, NetworkRequestError?) -> Void) {
        
        guard let response = response,
              response.statusCode == 200 else {
            completion(nil, .invalidResponse)
            return
        }
        
        guard value != nil else {
            completion(nil, .invalidData)
            return
        }
    }
}
