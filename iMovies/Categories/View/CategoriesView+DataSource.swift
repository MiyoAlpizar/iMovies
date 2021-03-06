//
//  CategoriesView+DataSource.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension CategoriesView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGenres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.NAME, for: indexPath) as! CategoryViewCell
        cell.categoryName.text = filteredGenres[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.goToGenreShows(type: showType, genre: filteredGenres[indexPath.row])
    }
    
}

