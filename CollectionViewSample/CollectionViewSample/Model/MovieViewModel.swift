//
//  MovieViewModel.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/7/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {
    var movieModels : [MovieModel] = [MovieModel]()
    var currentPage : Int          = 1
    var currentYear : Int          = 0
    private var totalResults  : String = "0"
    override init() {
        super.init()
        let date = Date()
        let calendar = Calendar.current
        currentYear = calendar.component(.year, from: date)
    }
    func getData(onCompletion : @escaping Constant.CompletionBlock){
        if currentPage > 1 {
            if Int(totalResults) == (movieModels.count - 1) {
                DispatchQueue.main.async {
                    self.currentPage = self.currentPage - 1
                    onCompletion("" as AnyObject , nil)
                }
                return
            }
        }
        ApiManager.sharedInstance.getDataForPage(_number: currentPage) { (json, error) in
            if let responseJson = json as? [String : Any] {
               self.parseData(data: responseJson)
            } else{
                 self.currentPage = self.currentPage - 1
            }
            DispatchQueue.main.async {
                onCompletion(json , error)
            }
        }
    }

    private func parseData(data : [String : Any]) {
       // movieModels
        if let searchData = data[Constant.JsonKeys.kSearch] as? [[String : Any]] {
            if currentPage == 1 {
                movieModels.removeAll()
            }
            for m_Data in searchData{
                prepareMovieModel(json: m_Data)
            }
        }
        totalResults = (data[Constant.JsonKeys.kTotalResults] as? String) ?? "0"
    }

    private func prepareMovieModel(json : [String : Any]) {
         let movie = MovieModel()
         movie.makeModel(json: json,currentYear: currentYear)
         movieModels.append(movie)
    }


}
