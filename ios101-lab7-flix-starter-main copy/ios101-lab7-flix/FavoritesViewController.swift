//
//  FavoritesViewController.swift
//  ios101-lab7-flix
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    
    
    var favoriteRecipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Register the cell class for the "RecipeCell" identifier
           tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
           
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Anything in the defer call is guaranteed to happen last
        defer {
            // Show the "Empty Favorites" label if there are no favorite movies
            emptyFavoritesLabel.isHidden = !favoriteRecipes.isEmpty
        }

        // TODO: Get favorite movies and display in table view
        // Get favorite movies and display in table view
        // 1. Get the array of favorite movies
        // 2. Set the favoriteMovies property so the table view data source methods will have access to latest favorite movies.
        // 3. Reload the table view
        // ------

        // 1.
        let recipes = Recipe.getRecipes(forKey: Recipe.favoritesKey)
        // 2.
        self.favoriteRecipes = recipes
        // 3.
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        // Get the movie associated table view row
        let recipe = favoriteRecipes[indexPath.row]
        
        // Configure the cell (i.e. update UI elements like labels, image views, etc.)
//
//        // Unwrap the optional poster path
//        if let strMealThumb = recipe.strMealThumb,
//
//               // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
//              let imageUrl = URL(string: strMealThumb) {
//
//               // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
//            Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
//           }
 
        print(recipe.strMeal)
        // Set the text on the labels
        cell.titleLabel.text = recipe.strMeal
        cell.categoryLabel.text = recipe.strCategory
        cell.overviewLabel.text = recipe.strInstructions

        // Return the cell for use in the respective table view row
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // MARK: - Pass the selected recipe to the Detail View Controller

        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedRecipe = favoriteRecipes[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.recipe = selectedRecipe
    }
}
