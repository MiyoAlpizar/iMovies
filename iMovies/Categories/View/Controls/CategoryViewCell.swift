//
//  CategoryViewCell.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    static let NAME = "CategoryViewCell"
    
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
