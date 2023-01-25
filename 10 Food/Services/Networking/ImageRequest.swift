//
//  ImageRequest.swift
//  10 Food
//
//  Created by Yevhen Biiak on 24.01.2023.
//

import UIKit

struct ImageRequest {
    var url: URL
    
    init(url: URL ) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    
    func decode(_ data: Data) throws -> UIImage {
        if let image = UIImage(data: data) {
            return image
        } else {
            throw NetworkRequestError.decodingError
        }
    }
}
