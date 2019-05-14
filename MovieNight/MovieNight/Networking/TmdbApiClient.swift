//
//  TmdbApiClient.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class TmdbApiClient: ApiClient {
    let session: URLSession
    let decoder = JSONDecoder()
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getCertificate(completion: @escaping (Result<Certificates, ApiError>) -> Void) {
        let certificate = Tmdb.certificate
        let request = certificate.request
        
        getData(with: request, completion: completion)
    }
    
    func getGenre(completion: @escaping (Result<Genres, ApiError>) -> Void) {
        let genre = Tmdb.genre
        let request = genre.request
        
        getData(with: request, completion: completion)
    }
    
    func getPeople(completion: @escaping (Result<PopularPeople, ApiError>) -> Void) {
        let people = Tmdb.people
        let request = people.request
        
        getData(with: request, completion: completion)
    }
    
    func getMovies(certificateCountry: String, certificate: String, page: String, genres: String, people: String, completion: @escaping (Result<Movies, ApiError>) -> Void) {
        let movies = Tmdb.movies(certificateCountry: certificateCountry, certificate: certificate, page: page, genres: genres, people: people)
        let request = movies.request
        
        getData(with: request, completion: completion)
    }
}
