//
//  RecipeCell.swift
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!

    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 18
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
