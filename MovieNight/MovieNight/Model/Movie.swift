//
//  Movie.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class Movies: Decodable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
}

class Movie: Decodable {
    let title: String
    let overview: String
    let releaseDate: String
}
