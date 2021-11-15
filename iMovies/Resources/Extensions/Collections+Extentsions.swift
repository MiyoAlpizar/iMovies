//
//  Collections+Extentsions.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//


import UIKit
import Differ

extension UICollectionView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
        animateItemChanges(oldData: old, newData: new, updateData: {
            
        })
        
    }
}

extension UITableView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
        animateRowChanges(oldData: old, newData: new)
    }
}
