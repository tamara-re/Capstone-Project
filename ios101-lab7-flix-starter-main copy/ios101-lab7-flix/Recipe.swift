//
//  Recipe.swift
//  Capstone_Project
//
//  Created by Tamara Regalado Quiroz on 11/17/23.
//

import Foundation


struct RecipeResponse: Decodable {
    let meals: [Recipe]
}

struct Recipe: Codable, Equatable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strInstructions: String
    
    let strMealThumb: String? // Path used to create a URL to fetch the poster image
    let strYoutube: String?

    
    // MARK: Additional properties for detail view
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    
    let strSource: String?
    
    
    // MARK: ID property to use when saving movie
    
    //    // MARK: Custom coding keys
    //    // Allows us to map the property keys returned from the API that use underscores (i.e. `poster_path`)
    //    // to a more "swifty" lowerCamelCase naming (i.e. `posterPath` and `backdropPath`)
    enum CodingKeys: String, CodingKey {
        case idMeal

        case strMeal
        case strCategory
        case strInstructions
        case strMealThumb
        case strYoutube

        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20

        case strSource
    }
}
                 


extension Recipe {
    static var favoritesKey: String {
        return "Favorites"
    }
    
    static func save(_ recipes: [Recipe], forKey key: String) {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        let encodedData = try! JSONEncoder().encode(recipes)
        // 3.
        defaults.set(encodedData, forKey: key)
    }
    
    static func getRecipes(forKey key: String) -> [Recipe] {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        if let data = defaults.data(forKey: key) {
            // 3.
            let decodedRecipes = try! JSONDecoder().decode([Recipe].self, from: data)
            // 4.
            return decodedRecipes
        } else {
            // 5.
            return []
        }
    }
    
    func addToFavorites() {
        // 1.
        var favoriteRecipes = Recipe.getRecipes(forKey: Recipe.favoritesKey)
        // 2.
        favoriteRecipes.append(self)
        // 3.
        Recipe.save(favoriteRecipes, forKey: Recipe.favoritesKey)
    }
    
    func removeFromFavorites() {
        // 1.
        var favoriteRecipes = Recipe.getRecipes(forKey: Recipe.favoritesKey)
        // 2.
        favoriteRecipes.removeAll { recipe in
            // 3.
            return self == recipe
        }
        // 4.
        Recipe.save(favoriteRecipes, forKey: Recipe.favoritesKey)
    }
    
}

