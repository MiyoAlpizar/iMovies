//
//  Enums.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

enum ShowType : String {
    case movie
    case serie = "tv"
    
    var description: String {
        switch self {
        case .movie:
            return "Movies"
        case .serie:
            return "Series"
        }
    }
}
