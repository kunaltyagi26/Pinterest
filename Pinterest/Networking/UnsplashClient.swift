//
//  UnsplashClient.swift
//  Pinterest
//
//  Created by Kunal Tyagi on 27/01/19.
//  Copyright © 2019 Kunal Tyagi. All rights reserved.
//

import Foundation

class UnsplashClient: APIClient {
    static let baseUrl = "https://api.unsplash.com"
    static let APIKey = "05ee3838a5209624ba96d97bf5ce3ed61d098693ef3c4d830a0685c4579fe375"
    
    func fetch(with endpoint: UnsplashEndpoint, completion: @escaping (Either<Photos>) -> Void) {
        let request = endpoint.request
        get(with: request, completion: completion)
    }
}
