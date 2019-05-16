//
//  MovieController.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class MovieController: UIViewController {
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var overview: UITextView!
    
    var artworkImage: UIImage?
    var movieOverview: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let artworkImage = artworkImage, let movieOverview = movieOverview {
            artwork.image = artworkImage
            overview.text = movieOverview
        }
        
    }
    

    

}
