//
//  ImageRequest.swift
//  10 Food
//
//  Created by Yevhen Biiak on 24.01.2023.
//

import UIKit

struct ImageRequest {
    var url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    
    typealias Model = UIImage
    
    func decode(_ data: Data) -> Result<UIImage, Error> {
        if let image = UIImage(data: data) {
            return .success(image)
        } else {
            return .failure(NetworkRequestError.decodingError)
        }
    }
}
