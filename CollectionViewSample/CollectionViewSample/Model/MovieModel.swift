//
//  MovieModel.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/7/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class MovieModel: NSObject {
    var title  : String! = ""
    var year   : String! = ""
    var imdb   : String! = ""
    var type   : String! = ""
    var poster : String! = ""
    var yearToDisplay : String?
    func makeModel(json : [String : Any], currentYear : Int) {
        title  = (json[Constant.JsonKeys.kTitle] as? String) ?? ""
        year   = (json[Constant.JsonKeys.kYear]  as? String) ?? ""
        imdb   = (json[Constant.JsonKeys.kImdbID]as? String) ?? ""
        type   = (json[Constant.JsonKeys.kType]  as? String) ?? ""
        poster = (json[Constant.JsonKeys.kPoster]as? String) ?? ""
        if !year.isEmpty {
            let movieYear : Int  = Int(year) ?? currentYear
            if movieYear > currentYear {
                yearToDisplay = "Yet to come"
            } else{
                let ago = currentYear - (Int(year) ?? currentYear)
                yearToDisplay = "" + String(ago) + " years ago"
            }
        }
    }
}
