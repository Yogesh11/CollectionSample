//
//  CollectionCell.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/4/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    func displayContent(movie : MovieModel) {
        titleLabel.text = movie.title
        posterImage.image = nil
        if let url = URL(string: movie.poster) , UIApplication.shared.canOpenURL(url) {
            posterImage.sd_setImage(with: url) { (image, error, cacheType, url) in
            }
        }
        type.text = movie.type
        year.text = movie.yearToDisplay
    }

}
