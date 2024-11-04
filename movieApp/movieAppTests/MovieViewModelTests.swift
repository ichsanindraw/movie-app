//
//  MovieViewModelTests.swift
//  movieAppTests
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation
import XCTest

@testable import movieApp

class MovieViewModelTests: XCTestCase {
    var mockRepo: MovieRepository!
    var useCase: MovieUseCase!
    var viewModel: MovieViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockRepo = MockMovieRepository()
        useCase = MovieUseCase(repository: mockRepo)
        viewModel = MovieViewModel(useCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        mockRepo = nil
        useCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetMovies() {
        let expectedMovies: [Movie] = [.mock2]
        let expectation = self.expectation(description: "success get movies")
        
//        mockRepo.getMovies(1)
//        
//        viewModel.getMovies()
//        
//        useCase.getMovies(page: 1)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print(">>> finished")
//                    break;
//                case .failure:
//                    print(">>> failure")
//                    break;
//                }
//            } receiveValue: { _ in
//                print(">>> success")
//            }
//            .store(in: &cancellables)
        
        viewModel.$viewState
            .sink { state in
                if case let .success(data) = state {
                    XCTAssertEqual(data, expectedMovies)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0)
    }
}

class MockMovieRepository: MovieRepository {
    var getSuccessMovie: Result<MovieResponse, NetworkError> = .success(.mock1)
    
    func getMovies(_ page: Int) -> AnyPublisher<movieApp.MovieResponse, movieApp.NetworkError> {
//        return Future { promise in
//            promise(self.getSuccessMovie)
//        }
//        .eraseToAnyPublisher()
        
        return Just(.mock1)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getGenres() -> AnyPublisher<movieApp.GenreResponse, movieApp.NetworkError> {
        return Just(GenreResponse(genres: []))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

extension MovieResponse {
    static let mock1 = MovieResponse(page: 1, results: [.mock1], totalPages: 1, totalResults: 1)
}

extension Movie {
    static let mock1 = Movie(adult: false, backdropPath: "", genreIDS: [], id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 0, voteCount: 0)
    
    static let mock2 = Movie(adult: false, backdropPath: "", genreIDS: [], id: 2, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 0, voteCount: 0)
}
