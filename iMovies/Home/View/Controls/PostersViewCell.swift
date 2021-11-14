//
//  BigPosterViewCell.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit

class PostersViewCell: UITableViewCell {

    static let NAME = "PostersViewCell"
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var cellDelegate: PosterViewCellProtocol?
    
    public var category: MovieCategory?
    {
        didSet {
            if let category = category {
                categoryName.text = category.description
            }
        }
    }
    public var movies = [Movie]()
    {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "MoviePosterCell", bundle: nil), forCellWithReuseIdentifier: MoviePosterCell.NAME)
        collectionView.collectionViewLayout = layout
        
    }
}


