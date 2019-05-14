//
//  Endpoint.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: base)!
        component.path = path
        component.queryItems = queryItems
        
        return component
    }
    
    var request: URLRequest {
        let url = urlComponent.url!
        return URLRequest(url: url)
    }
}

enum Tmdb {
    case certificate
    case genre
    case people
    case movies(certificateCountry: String, certificate: String, page: String, genres: String, people: String)
}

extension Tmdb: Endpoint {
    private var apiKey: String {
        return "b6fe7d859b4cc9b9d3b4472336700279"
    }
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .certificate: return "/3/certification/movie/list"
        case .genre: return "/3/genre/movie/list"
        case .people: return "/3/person/popular"
        case .movies: return "/3/discover/movie"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .certificate, .genre, .people:
            return [URLQueryItem(name: "api_key", value: apiKey)]
        case let .movies(certificateCountry, certificate, page, genres, people):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "certification_country", value: certificateCountry),
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "with_genres", value: genres),
                URLQueryItem(name: "certification.lte", value: certificate),
                URLQueryItem(name: "with_people", value: people)
            ]
        }
    }
}


























