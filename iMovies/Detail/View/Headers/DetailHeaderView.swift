//
//  DetailHeaderView.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import UIKit

class DetailHeaderView: UIView {
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAvarage: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var btnAddToList: UIButton!
    class func instanceFromNib() -> DetailHeaderView {
        return UINib(nibName: "DetailHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailHeaderView
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
}
