//
//  DetailRouter.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class DetailRouter {
    
    var viewController: DetailView {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> DetailView {
        return DetailView.instance()
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }
}
