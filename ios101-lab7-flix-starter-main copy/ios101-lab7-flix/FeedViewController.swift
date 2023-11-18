//
//  FeedViewController.swift
//

import UIKit
import Nuke

// Add table view data source conformance
class FeedViewController: UIViewController, UITableViewDataSource {

    // Add table view outlet
    
    private var recipes: [Recipe] = []

    
    @IBOutlet weak var tableView: UITableView!
    
    
    // Add property to store fetched movies array
    private var Recipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        // Assign table view data source
        tableView.dataSource = self

        fetchRecipes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // get the index path for the selected row
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            // Deselect the currently selected row
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("🍏 numberOfRowsInSection called with movies count: \(Recipes.count) ")
        // \(Recipes.count)

        // Return the number of rows for the table.
        return Recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure and return a table view cell for the given row (i.e. `indexPath.row`)

         print("🍏 cellForRowAt called for row: \(indexPath.row)")

        // Get a reusable cell
        // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps to optimize table view performance as the app only needs to create enough cells to fill the screen and can reuse cells that scroll off the screen instead of creating new ones.
        // The identifier references the identifier you set for the cell previously in the storyboard.
        // The `dequeueReusableCell` method returns a regular `UITableViewCell` so we need to cast it as our custom cell (i.e. `as! MovieCell`) in order to access the custom properties you added to the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell

        // Get the recipe associated table view row
        let recipe = Recipes[indexPath.row]

//        let recipe = Recipes[indexPath.row]

        // Configure the cell (i.e. update UI elements like labels, image views, etc.)

        // Unwrap the optional poster path
        if let strMealThumb = recipe.strMealThumb,

           let imageUrl = URL(string: strMealThumb) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
        }

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
        let selectedRecipe = Recipes[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.recipe = selectedRecipe
    }

    // Fetches a list of popular recipes from the TMDB API
    
    private func fetchRecipes() {
        // URL for the TMDB Get Popular movies endpoint: https://developers.themoviedb.org/3/movies/get-popular-movies
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f=p")!
        
        
        //https://api.themoviedb.org/3/movie/popular?api_key=b1446bbf3b4c705c6d35e7c67f59c413&language=en-US&page=1

        // Create the URL Session to execute a network request given the above url in order to fetch our recipe data.
        //https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
        // ---
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check for errors
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                
                if let underlyingError = error as? URLError {
                        print("Underlying URLError: \(underlyingError)")
                    }

                    return
                
            }
            
            // Check for server errors
            // Make sure the response is within the `200-299` range (the standard range for a successful response).
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }
            print("🍌 http response: \(String(describing: httpResponse))")

            
            
            // Check for data
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }
            
            print("🍌Received data: \(String(data: data, encoding: .utf8) ?? "No data")")

            
            // The JSONDecoder's decode function can throw an error. To handle any errors we can wrap it in a `do catch` block.
            do {
                let decoder = JSONDecoder()

                print("🍌Decoder input data: \(data)")

                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)

                print("🍌recipe response: \(recipeResponse)")

                // Access the array of movies
                let recipes = recipeResponse.meals
                print("🍌 recipes:  \(recipes)")


                // Decode the JSON data into our custom `MovieResponse` model.
//                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                print("🍌recipe response: \(recipeResponse)")

                
                print("🍌 recipes:  \(recipes)")
                
                // Runs any code that will update UI on the main thread. asynchronosuly, you don't have to wait
                DispatchQueue.main.async { [weak self] in
                    
                    // Update the movies property so we can access movie data anywhere in the view controller.
                    //storing the data we got back
                    self?.recipes = recipes
                    
                    self?.tableView.reloadData()
                    
                    print("🍏 Fetched and stored \(recipes.count) recipes")
                    
                    //NEED to reload dat to get RowsAt to get the info
                    self?.tableView.reloadData()
                    
                    // We have movies! Do something with them!
                    print("✅ SUCCESS!!! Fetched \(recipes.count) recipes")

                    // MARK: - Update the movies property so we can access movie data anywhere in the view controller.
                    self?.Recipes = recipes
                    // print("🍏 Fetched and stored \(movies.count) movies")

                    // Prompt the table view to reload its data (i.e. call the data source methods again and re-render contents)
                    self?.tableView.reloadData()
                }
            } catch {
                print("🚨 Error decoding JSON data into Movie Response: \(error.localizedDescription)")
                return
            }
        }

        // Don't forget to run the session!
        session.resume()
    }


}
