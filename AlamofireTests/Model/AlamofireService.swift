//
//  AlamofireService.swift
//  AlamofireTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation
import Alamofire


enum NetworkRequestError: Error {
    case statusCode(Int)
    case serializationError(Error?)
    case invalidResponse
    case invalidData
    case noIngredients
    case noRecipes
}

protocol NetworkRequest {
    func getRecipes(with ingredients: [String], completion: @escaping (_ recipes: [Recipe]?,_ error: NetworkRequestError?) -> Void)
}

class AlamofireService {
    // MARK: - Properties
    private let baseURL         = "https://api.edamam.com/search?"
    private let APP_ID          = "08b5ed9a"
    private let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
    private let maxRecipes      = 1
    
    static let shared = AlamofireService()
    private init() {}
}

extension AlamofireService: NetworkRequest {
    
    private func createURL(with ingredients: [String]) -> URL? {
        guard !ingredients.isEmpty else { return nil }
        
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += "\(ingredient),"
        }
        
        let urlString = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        return URL(string: urlString)
    }
    
    
    private func convertDictToRecipes(_ dict: [String : Any]) -> [Recipe]? {
        guard let hits = dict["hits"] as? [AnyObject],
              !hits.isEmpty else { return nil }
        
        var recipes = [Recipe]()
        for hit in hits {
            guard let recipe = hit["recipe"] as? [String: Any],
                  let label = recipe["label"] as? String else { return nil }
            
            let object = Recipe(label: label)
            recipes.append(object)
        }
        
        return recipes
    }
    
    
    func getRecipes(with ingredients: [String], completion: @escaping (_ recipes: [Recipe]?,_ error: NetworkRequestError?) -> Void) {
        
        guard let url = createURL(with: ingredients) else {
            completion(nil, .noIngredients)
            return
        }
        
        AF.request(url).validate().responseJSON { response in
            guard let value = response.value as? [String: Any] else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let recipes = self.convertDictToRecipes(value) else {
                completion(nil, .noRecipes)
                return
            }
            
            completion(recipes, nil)
        }
    }
    
}
