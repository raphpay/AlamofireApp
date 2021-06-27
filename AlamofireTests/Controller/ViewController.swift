//
//  ViewController.swift
//  AlamofireTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let alamofireService    = AlamofireService.shared
    
    let ingredients = ["Rice"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
//        alamofireService.getRecipes(with: ingredients) { _recipes, _error in
//            print("====================\n recipes \(_recipes) \n====================")
//            print("====================\n error \(_error) \n====================")
//        }
    }


}

