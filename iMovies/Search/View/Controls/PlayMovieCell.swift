//
//  PlayMovieCell.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class PlayMovieCell: UITableViewCell {

    static let NAME = "PlayMovieCell"
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            if movie.backdropPath != nil {
                posterImage.sd_setImage(with: movie.backdropURL, completed: nil)
            }
            titleLbl.text = movie.title
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
