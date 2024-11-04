//
//  MovieTarget.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Foundation
import Moya

enum MovieTarget {
    case getMovies(page: Int)
    case getGenres
}

extension MovieTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.APP_URL)!
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "movie/popular"
            
        case .getGenres:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies, .getGenres:
            return .get
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(
            parameters: parameter,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default
        )
    }
    
    var parameter: [String: Any] {
        switch self {
        case let .getMovies(page):
            return [
                "language": "en-US",
                "page": page
            ]
        case .getGenres:
            return [
                "language": "en",
            ]
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}
