//
//  CategoriesRouter.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit

class CategoriesRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        return CategoriesView.instance()
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }
}

