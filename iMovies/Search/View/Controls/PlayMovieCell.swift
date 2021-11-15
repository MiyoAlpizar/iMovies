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
    
    var showInfo: ShowInfo? {
        didSet {
            guard let showInfo = showInfo else {
                return
            }
            if showInfo.landscapePoster != nil {
                posterImage.sd_setImage(with: showInfo.landscapePoster!, completed: nil)
            }
            titleLbl.text = showInfo.name
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
