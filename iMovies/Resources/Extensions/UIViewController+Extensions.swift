//
//  UIViewController+Extensions.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    static func instance() -> Self {
        let id = String(describing: self)
        return Self(nibName: id, bundle: Bundle.main)
    }
}
