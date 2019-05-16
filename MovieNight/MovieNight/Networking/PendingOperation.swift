//
//  PendingOperation.swift
//  MovieNight
//
//  Created by Dipanshu Sehrawat on 15/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
