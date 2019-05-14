//
//  ApiError.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 14/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalidResponse
    case invalidData
    case invalidStatusCode
    case jsonParsingError
}
