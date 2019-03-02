//
//  ShowPhotoRouter.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 27/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ShowPhotoDataPassing {
    var dataStore: ShowPhotoDataStore? { get }
}

class ShowPhotoRouter: ShowPhotoDataPassing {

    weak var viewController: ShowPhotoViewController?
    var dataStore: ShowPhotoDataStore?
}
