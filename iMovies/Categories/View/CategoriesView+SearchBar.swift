//
//  CategoriesView+SearchBar.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension CategoriesView : UISearchControllerDelegate {
    func searchBarCancelButtonCliecked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
