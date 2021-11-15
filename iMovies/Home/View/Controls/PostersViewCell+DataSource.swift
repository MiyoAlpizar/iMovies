//
//  PostersViewCell+DataSource.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

extension PostersViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.NAME, for: indexPath) as! MoviePosterCell
        cell.posterPath = showInfo[indexPath.row].landscapePoster
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = cellDelegate else {
            return
        }
        //delegate.onPosterPressed(movie: movies[indexPath.row])
    }
}
