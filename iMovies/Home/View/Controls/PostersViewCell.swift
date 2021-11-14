//
//  BigPosterViewCell.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit

class PostersViewCell: UITableViewCell {

    static let NAME = "PostersViewCell"
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var category: MovieCategory?
    
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
        layout.itemSize = CGSize(width: 200, height: 260)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "MoviePosterCell", bundle: nil), forCellWithReuseIdentifier: MoviePosterCell.NAME)
        
    }
}

extension PostersViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let category = category else {
            return Constants.Sizes.MediumPoster
        }
        if category == .popular {
            return Constants.Sizes.BigPoster
        }
        return Constants.Sizes.MediumPoster
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.NAME, for: indexPath) as! MoviePosterCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
