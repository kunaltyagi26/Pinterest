//
//  PhotoCell.swift
//  Pinterest
//
//  Created by Kunal Tyagi on 14/01/19.
//  Copyright © 2019 Kunal Tyagi. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: UIImage) {
        imageView.image = image
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
    }
}
