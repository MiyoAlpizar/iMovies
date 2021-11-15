//
//  SearchRouter.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class SearchRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        return SearchView.instance()
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }
    
    func openDetail(showInfo: ShowInfo) {
        let detailView = DetailRouter().viewController
        detailView.showInfo = showInfo
        sourceView?.present(detailView, animated: true, completion: nil)
    }
}
