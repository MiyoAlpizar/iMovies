//
//  MoviesGener+DataSource.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension MoviesGenreView {
   
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.NAME, for: indexPath) as! MoviePosterCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.openDetail(movie: movies[indexPath.row])
    }
    
    
    
}
