//
//  MoviesGener+DataSource.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension ShowsView {
   
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showsInfo.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.NAME, for: indexPath) as! MoviePosterCell
        cell.posterPath = showsInfo[indexPath.row].portraitPoster
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.openDetail(showInfo: showsInfo[indexPath.row])
    }
    
    
    
}
