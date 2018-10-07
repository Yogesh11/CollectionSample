//
//  DetailCell.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/7/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var year: UILabel!
     @IBOutlet weak var type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.contentMode = .scaleAspectFit
    }

    func drawUI(movie : MovieModel) {
        movieImage.image = nil
        if let url = URL(string: movie.poster) , UIApplication.shared.canOpenURL(url) {
            movieImage.sd_setImage(with: url) { (image, error, cacheType, url) in
            }
        }
        movieName.text = movie.title
        type.text = movie.type
        year.text = movie.yearToDisplay
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
