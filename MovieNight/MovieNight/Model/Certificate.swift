//
//  Certificate.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class Certificate: Decodable {
    let certification: String
    let order: Int
}

class USCertificate: Decodable {
    let US: [Certificate]
}

class Certificates: Decodable {
    let certifications: USCertificate
}


