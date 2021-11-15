//
//  SearchView+SearchController.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension SearchView : UISearchControllerDelegate {
    func searchBarCancelButtonCliecked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
}
