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
}

final class Router {
    private var tasks: [URL: [RouterRequestCompletion]] = [:]

    // MARK: - Build URLRequest from EndPoint

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

    // MARK: - Handle Response

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

    // MARK: - Handle Succes (after response)

    private func handleSucces(_ data: Data?) -> Result<Data, NetworkError> {
        if let responseData: Data = data {
            return .success(responseData)
        } else {
            return .failure(.noData)
        }
    }

    // MARK: - Log Network calls

    private func log(_ request: URLRequest) {

        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"

        var requestLog = "\n---------- REQUEST ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody {
            if let bodyString: String = String(data: body, encoding: String.Encoding.utf8) {
                requestLog += "\n\(bodyString)\n"
            }
        }

        requestLog += "\n------------------------->\n"
        print(requestLog)
    }

    private func log(data: Data?, response: URLResponse?, error: Error?) {
        let response = response as? HTTPURLResponse

        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- RESPONSE ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        if let statusCode = response?.statusCode {
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            if let bodyString: String = String(data: body, encoding: String.Encoding.utf8) {
                responseLog += "\n\(bodyString)\n"
            } else {
                responseLog += "\nIMAGE DATA\n"
            }
        }
        if let error = error {
            responseLog += "\nError: \(String(describing: error.localizedDescription))\n"
        }

        responseLog += "<------------------------\n"
        print(responseLog)
    }
}

// MARK: - NetworkRouter

extension Router: NetworkRouter {
    func request(_ route: EndPoint, completion: @escaping RouterRequestCompletion) {
        let session: URLSession = URLSession(configuration: .default)

        do {
            let request: URLRequest = try buildRequest(from: route)
            guard let url = request.url else { completion(.failure(.badURL)); return }

            if tasks.keys.contains(url) {
                tasks[url]?.append(completion)
            } else {
                tasks[url] = [completion]
                log(request)
                _ = session.dataTask(with: request) { [unowned self] data, response, error in
                    DispatchQueue.main.async {
                        self.log(data: data, response: response, error: error)
                        guard let completionHandlers = self.tasks[url] else { completion(.failure(.failed)); return }
                        completionHandlers.forEach { _ in
                            completion(self.handleResponse(data: data, response: response, error: error))
                        }
                    }
                }.resume()
            }

        } catch let error as NetworkError {
            completion(Result.failure(error))
        } catch {
            completion(Result.failure(NetworkError.failed))
        }
    }
}
