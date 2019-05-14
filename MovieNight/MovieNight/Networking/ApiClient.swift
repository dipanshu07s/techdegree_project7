//
//  TmdbApiClient.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

protocol ApiClient {
    var session: URLSession { get }
    var decoder: JSONDecoder { get }
    
    func getData<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, ApiError>) -> Void)
}

extension ApiClient {
    func getData<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, ApiError>) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let result = try self.decoder.decode(T.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(.jsonParsingError))
                        }
                    } else {
                        completion(.failure(.invalidStatusCode))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            }
            
        }
        
        task.resume()
    }
}
