//
//  MoviePosterCell.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit
import SDWebImage
class MoviePosterCell: UICollectionViewCell {
    
    static let NAME = String(describing: self)
    
    @IBOutlet weak var posterImage: UIImageView!
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            guard movie.posterPath != nil else {
                return
            }
            guard posterImage != nil else {
                return
            }
            posterImage.sd_setImage(with: movie.posterURL, completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
