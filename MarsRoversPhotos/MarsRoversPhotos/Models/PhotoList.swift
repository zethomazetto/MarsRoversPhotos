//
//  PhotoList.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 27/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import Foundation

struct PhotoList: Codable {
    let photos: [Photo]
    
    init() {
        photos = [Photo]()
    }
}
