//
//  Photo.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 25/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let img_src: String
    let camera: Camera
}
