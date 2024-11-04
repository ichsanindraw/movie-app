//
//  MovieViewModel.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation

class MovieViewModel: ObservableObject {
    @Published var viewState: ViewState<[Movie]> = .loading
    @Published var genres: [Genre] = []
    
    private var currentPage: Int = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    private let useCase: MovieUseCase
    
    init(useCase: MovieUseCase = MovieUseCase(repository: MovieRepositoryImpl())) {
        self.useCase = useCase
    }
    
    func getMovies() {
        viewState = .loading
        
        useCase.getMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] completion in
                switch completion {
                case .finished:
                    self?.getGenres()
                    break
                    
                case let .failure(error):
                    self?.viewState = .error(error)
                    break
                }
            } receiveValue: { [weak self] response in
                self?.viewState = .success(response.results)
            }
            .store(in: &cancellables)
    }
    
    func getGenres() {
        useCase.getGenres()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                    
                case let .failure(error):
                    break
                }
            } receiveValue: { [weak self] response in
                self?.genres = response.genres
            }
            .store(in: &cancellables)
    }
}

enum ViewState<D: Decodable> {
    case loading
    case error(NetworkError)
    case success(D)
}
