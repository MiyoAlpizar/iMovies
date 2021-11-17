//
//  HomeRouter.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

class HomeRouter  {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        return HomeView.instance()
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
