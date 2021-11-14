//
//  HomeView+DataSource.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

extension HomeView: PosterViewCellProtocol {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeMovies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeMovies[section].movies.count > 0 ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostersViewCell.NAME) as! PostersViewCell
        cell.category = homeMovies[indexPath.section].category
        cell.movies = homeMovies[indexPath.section].movies
        cell.cellDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if homeMovies[indexPath.section].category == .popular {
            return Constants.Sizes.BigPoster.height
        }
        return Constants.Sizes.MediumPoster.height
    }
    
    func onPosterPressed(movie: Movie) {
        router.openDetail(movie: movie)
    }
    
}
