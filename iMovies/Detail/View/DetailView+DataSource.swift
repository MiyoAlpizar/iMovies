//
//  DetailMovie+DataSource.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import Foundation
import UIKit

extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostersViewCell.NAME) as! PostersViewCell
        cell.category = .similiar
        cell.showInfo = similarShows
        //cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let showInfo = showInfo else { return nil }
        let headerView = DetailHeaderView.instanceFromNib()
        headerView.imgPoster.sd_setImage(with: showInfo.landscapePoster!, completed: nil)
        headerView.lblTitle.text = showInfo.name
        headerView.lblDate.text = "R - \(showInfo.date ?? "No date")"
        headerView.lblAvarage.text = "\(showInfo.voteAverage)%"
        headerView.lblOverView.text = showInfo.overview
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Sizes.MediumPoster.height
    }
    
}
