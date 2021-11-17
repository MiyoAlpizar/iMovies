//
//  PostersViewCell+FlowLayout.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//
import UIKit

extension PostersViewCell:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let category = category else {
            return Constants.Sizes.MediumPoster
        }
        if category == .popular {
            return Constants.Sizes.BigPoster
        }
        return Constants.Sizes.MediumPoster
    }
}
