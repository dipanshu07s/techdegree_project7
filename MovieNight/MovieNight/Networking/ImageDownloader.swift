//
//  ImageDownloader.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 15/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)") else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {
            movie.artwork = UIImage(data: imageData)
            movie.artworkState = .downloaded
        } else {
            movie.artworkState = .failed
        }
    }
}
