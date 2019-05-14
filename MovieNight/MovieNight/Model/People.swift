//
//  People.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class PopularPeople: Decodable {
    let results: [People]
}

class People: Decodable {
    let id: Int
    let name: String
}
