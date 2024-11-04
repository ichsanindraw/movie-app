//
//  NetworkManager.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation
import Moya

class NetworkManager<Target: TargetType> {
    private let provider: MoyaProvider<Target>
    
    init() {
        provider = MoyaProvider(
            plugins: [
                AuthPlugin()
            ]
        )
    }
    
    func request<D: Decodable> (
        _ target: Target,
        responseType: D.Type
    ) -> AnyPublisher<D, NetworkError> {
        let subject = PassthroughSubject<D, NetworkError>()
        
        provider.request(target) { result in
            switch result {
            case let .failure(moyaError):
                subject.send(completion: .failure(.moyaError(moyaError)))
                
            case let .success(response):
                do {
                    let successResponse = try JSONDecoder().decode(D.self, from: response.data)

                    subject.send(successResponse)
                    subject.send(completion: .finished)
                } catch {
                    #if DEBUG
                        print(">>> Error: \(error)")
                    #endif
                    
                    subject.send(completion: .failure(.moyaError(.jsonMapping(response))))
                }
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case moyaError(MoyaError)
    case serverError(String)
}

class AuthPlugin: PluginType {
    init() {}
    
    private var request: (RequestType, TargetType)?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
//        let credentials = "Bearer \(Constants.BEARER_TOKEN)"
        
//        if let credentialsData = credentials.data(using: .utf8) {
            request.setValue("Bearer \(Constants.BEARER_TOKEN)", forHTTPHeaderField: "Authorization")
//            request.setValue(credentialsData.base64EncodedString(), forHTTPHeaderField: "Authorization")
//        }
        
        return request
    }
}
