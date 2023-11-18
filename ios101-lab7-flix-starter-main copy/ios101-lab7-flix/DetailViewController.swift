//
//  DetailViewController.swift
//  ios101-lab6-flix
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageShadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeVideo: UILabel!

    @IBOutlet weak var overviewTextView: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // TODO: Add favorite button outlet
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var ingredientOne: UILabel!
    
    @IBOutlet weak var ingredientTwo: UILabel!
    
    @IBOutlet weak var ingredientThree: UILabel!
    
    @IBOutlet weak var ingredient4: UILabel!
    
    @IBOutlet weak var ingredient5: UILabel!
    
    @IBOutlet weak var ingredient6: UILabel!
    
    @IBOutlet weak var ingredient7: UILabel!
    
    @IBOutlet weak var ingredient8: UILabel!
    
    @IBOutlet weak var measure1: UILabel!
    
    @IBOutlet weak var measure2: UILabel!
    
    @IBOutlet weak var measure3: UILabel!
    
    @IBOutlet weak var measure4: UILabel!
    
    @IBOutlet weak var measure5: UILabel!
    @IBOutlet weak var measure6: UILabel!
    
    @IBOutlet weak var measure7: UILabel!
    
    @IBOutlet weak var measure8: UILabel!
    
    // TODO: Add favorite button action
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        // Set the button's isSelected state to the opposite of it's current value.
        if sender.isSelected {
            // 1.
            recipe.addToFavorites()
            
        } else {
            // 2.
            recipe.removeFromFavorites()
        }
//
        
        
    }
    
    var recipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Update favorite button selected state

        // Set the button's corner radius to be 1/2  it's width. This will make a square button round.
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        
        // Update the button's selected state based on the current movie's favorited status.
        // 1. Get the array of favorite movies.
        // 2. Check if the favorite movies array contains the current movie.
        // 3. If so, the movie has been favorited -> Set the button to the *selected* state.
        // 4. Otherwise, the movie is not-favorited -> Set the button to the *un-selected* state.
        // ------

        // 1.
        let favorites = Recipe.getRecipes(forKey: Recipe.favoritesKey)
        // 2.
        if favorites.contains(recipe) {
            // 3.
            favoriteButton.isSelected = true
        } else {
            // 4.
            favoriteButton.isSelected = false
        }

        // MARK: Style views
        posterImageView.layer.cornerRadius = 20
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.white.cgColor

        posterImageShadowView.layer.cornerRadius = posterImageView.layer.cornerRadius
        posterImageShadowView.layer.shadowColor = UIColor.black.cgColor
        posterImageShadowView.layer.shadowOpacity = 0.5
        posterImageShadowView.layer.shadowOffset = CGSize(width: -3, height: 0)
        posterImageShadowView.layer.shadowRadius = 5

        // MARK: - Set text for labels
        titleLabel.text = recipe.strMeal
        
        categoryLabel.text = recipe.strCategory
        
//        recipeSource.text = recipe.strSource
        if let strSource = recipe.strSource{
            recipeSource.text = strSource

        } else {

            recipeSource.text = "n/a"
        }
        
        recipeVideo.text = recipe.strYoutube
        
        overviewTextView.text = recipe.strInstructions
        
        
        

        // Unwrap the optional vote average
        if let strIngredient1 = recipe.strIngredient1 {
            ingredientOne.text = strIngredient1
            
        } else {

            // if vote average is nil, set vote average label text to empty string
            ingredientOne.text = ""
        }

        if let strIngredient2 = recipe.strIngredient2{
            ingredientTwo.text = strIngredient2

        } else {

            // if vote average is nil, set vote average label text to empty string
            ingredientTwo.text = ""
        }
        
        if let strIngredient3 = recipe.strIngredient3 {
            ingredientThree.text = strIngredient3

        } else {

            // if vote average is nil, set vote average label text to empty string
            ingredientThree.text = ""
        }
        
        if let strIngredient4 = recipe.strIngredient4 {
            ingredient4.text = strIngredient4

        } else {

            // if vote average is nil, set vote average label text to empty string
            ingredient4.text = ""
        }
        
        if let strIngredient5 = recipe.strIngredient5 {
            ingredient5.text = strIngredient5

        } else {
            ingredient5.text = ""
        }
        
        if let strIngredient6 = recipe.strIngredient6 {
            ingredient6.text = strIngredient6

        } else {

            ingredient6.text = ""
        }
        
        if let strIngredient7 = recipe.strIngredient7 {
            ingredient7.text = strIngredient7

        } else {

            ingredient7.text = ""
        }
        
        if let strIngredient8 = recipe.strIngredient8 {
            ingredient8.text = strIngredient8

        } else {

            ingredient8.text = ""
        }
        
        if let strMeasure1 = recipe.strMeasure1{
            measure1.text = strMeasure1

        } else {

            measure1.text = ""
        }
        
        if let strMeasure2 = recipe.strMeasure2 {
            measure2.text = strMeasure2

        } else {

            measure2.text = ""
        }
        
        if let strMeasure3 = recipe.strMeasure3 {
            measure3.text = strMeasure3

        } else {

            measure3.text = ""
        }
        
        if let strMeasure4 = recipe.strMeasure4 {
            measure4.text = strMeasure4

        } else {
            measure4.text = ""
        }
        
        if let strMeasure5 = recipe.strMeasure5 {
            measure5.text = strMeasure5

        } else {

            measure5.text = ""
        }
        
        if let strMeasure6 = recipe.strMeasure6 {
            measure6.text = strMeasure6

        } else {

            measure6.text = ""
        }
        
        if let strMeasure7 = recipe.strMeasure7 {
            measure7.text = strMeasure7

        } else {

            measure7.text = ""
        }
        
        if let strMeasure8 = recipe.strMeasure8 {
            measure8.text = strMeasure8
            
        } else {
            measure8.text = ""
        }
        
        
        
        

        // MARK: - Fetch and set images for image views

        // Unwrap the optional poster path
        if let strMealThumb = recipe.strMealThumb,

            // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
           let imageUrl = URL(string: strMealThumb) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: imageUrl, into: posterImageView)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
