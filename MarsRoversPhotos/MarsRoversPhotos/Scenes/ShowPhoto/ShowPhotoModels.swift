//
//  ShowPhotoModels.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 27/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

enum ShowPhoto {
    
    enum GetPhoto {
        
        struct Request {
        }
        
        struct Response {
            var photo: Photo
        }
        
        struct ViewModel {
            
            struct DisplayedPhoto {
                var name: String
                var full_name: String
                var photoURL: URL
            }
            
            var displayedPhoto: DisplayedPhoto
        }
    }
}
