//
//  ViewModel.swift
//  Pinterest
//
//  Created by Kunal Tyagi on 27/01/19.
//  Copyright © 2019 Kunal Tyagi. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel {
    let image: UIImage
}

class ViewModel {
    private let client: APIClient
    private var photos: Photos = [] {
        didSet {
            fetchPhoto()
        }
    }
    var cellViewModels: [CellViewModel] = []
    
    var isLoading = false {
        didSet {
            showLoading?()
        }
    }
    
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    init(client: APIClient) {
        self.client = client
    }
    
    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true
            let endpoint = UnsplashEndpoint.photos(id: UnsplashClient.APIKey, order: .latest)
            client.fetch(with: endpoint) { (either) in
                switch either {
                case .success(let photos):
                    self.photos = photos
                case .error(let error):
                    self.showError?(error)
                }
            }
        }
    }
    
    private func fetchPhoto() {
        let group = DispatchGroup()
        self.photos.forEach { (photo) in
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf: photo.url.small) else {
                    self.showError?(APIError.imageDownload)
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    self.showError?(APIError.imageConvert)
                    return
                }
                
                self.cellViewModels.append(CellViewModel(image: image))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()
        }
    }
}
