//
//  Movie.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation
import UIKit

enum MovieArtworkState {
    case none
    case downloaded
    case failed
}

class Movies: Decodable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
}

class Movie: Decodable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    var artwork: UIImage?
    var artworkState = MovieArtworkState.none
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case releaseDate
        case posterPath
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
    }
}
