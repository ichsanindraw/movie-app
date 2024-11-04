//
//  GenreModel.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

