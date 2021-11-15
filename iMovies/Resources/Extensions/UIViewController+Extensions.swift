//
//  UIViewController+Extensions.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    ///Create instance from itself
    static func instance() -> Self {
        let id = String(describing: self)
        return Self(nibName: id, bundle: Bundle.main)
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
}
