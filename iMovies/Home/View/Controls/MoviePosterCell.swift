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
    
   
    public var posterPath: URL? {
        didSet {
            guard let url =  posterPath else {
                return
            }
            posterImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
