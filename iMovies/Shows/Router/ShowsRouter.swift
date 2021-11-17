//
//  MoviesGenderRouter.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class ShowsRouter {
    
    var viewController: ShowsView {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> ShowsView {
        return ShowsView.instance()
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }
    
    func openDetail(showInfo: ShowInfo) {
        let detailView = DetailRouter().viewController
        detailView.showInfo = showInfo
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.navigationController?.isNavigationBarHidden = true
        sourceView?.present(navigationController, animated: true, completion: nil)
    }
    
}
