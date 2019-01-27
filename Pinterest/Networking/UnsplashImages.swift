//
//  UnsplashImages.swift
//  Pinterest
//
//  Created by Kunal Tyagi on 27/01/19.
//  Copyright © 2019 Kunal Tyagi. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

struct Photo: Codable {
    let id: String
    let url: Urls
}

struct Urls: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
