//
//  SearchView+DataSource.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

extension SearchView {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayMovieCell.NAME, for: indexPath) as! PlayMovieCell
        cell.showInfo = showsInfo[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.openDetail(showInfo: showsInfo[indexPath.row])
        delayWithSeconds(0.3) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
