//
//  HomeRouter.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

class HomeRouter {
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
    
}