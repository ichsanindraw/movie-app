//
//  MovieUseCase.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation

protocol MovieRepository {
    func getMovies(_ page: Int) -> AnyPublisher<MovieResponse, NetworkError>
    func getGenres() -> AnyPublisher<GenreResponse, NetworkError>
}

class MovieRepositoryImpl: MovieRepository {
    private let networkManager = NetworkManager<MovieTarget>()
    
    func getMovies(_ page: Int) -> AnyPublisher<MovieResponse, NetworkError> {
        networkManager.request(.getMovies(page: page), responseType: MovieResponse.self)
    }
    
    func getGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        networkManager.request(.getGenres, responseType: GenreResponse.self)
    }
}

class MovieUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getMovies(page: Int) -> AnyPublisher<MovieResponse, NetworkError> {
        repository.getMovies(page)
    }
    
    func getGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        repository.getGenres()
    }
}
