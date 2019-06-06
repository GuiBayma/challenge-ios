//
//  Router.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 06/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import UIKit

typealias RouterRequestCompletion = (Result<Data, NetworkError>) -> Void

protocol NetworkRouter {
    func request(_ route: EndPoint, completion: @escaping RouterRequestCompletion)
    func cancel()
}

final class Router {
    private var task: URLSessionTask?

    private func buildRequest(from endPoint: EndPoint) throws -> URLRequest {
        guard let url = endPoint.url else {
            throw NetworkError.badURL
        }

        var request: URLRequest = URLRequest(url: url,
                                             cachePolicy: .returnCacheDataElseLoad,
                                             timeoutInterval: 60)
        request.httpMethod = endPoint.httpMethod.rawValue

        if let headers: HTTPHeaders = endPoint.headers {
            addHeaders(headers, request: &request)
        }

        return request
    }

    private func addHeaders(_ headers: HTTPHeaders, request: inout URLRequest) {
        headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) -> Result<Data, NetworkError> {
        if error != nil {
            return .failure(.failed)
        }

        guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
            return .failure(.emptyResponse)
        }

        switch response.statusCode {
        case 200...299:
            return handleSucces(data)
        case 401:
            return .failure(.unauthorized)
        case 403:
            return .failure(.forbidden)
        case 404:
            return .failure(.notFound)
        case 501...599:
            return .failure(.badRequest)
        case 600:
            return .failure(.outdated)
        default:
            return .failure(.failed)
        }
    }

    private func handleSucces(_ data: Data?) -> Result<Data, NetworkError> {
        if let responseData: Data = data {
            return .success(responseData)
        } else {
            return .failure(.noData)
        }
    }
}

// MARK: - NetworkRouter

extension Router: NetworkRouter {
    func request(_ route: EndPoint, completion: @escaping RouterRequestCompletion) {
        let session: URLSession = URLSession(configuration: .default)

        do {
            let request: URLRequest = try buildRequest(from: route)
            task = session.dataTask(with: request) { [unowned self] data, response, error in
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        } catch let error as NetworkError {
            completion(Result.failure(error))
        } catch {
            completion(Result.failure(NetworkError.failed))
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
}
