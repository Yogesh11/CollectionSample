//
//  Constant.swift
//  ShareChat
//
//  Created by Yogesh on 7/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct Constant {
    struct Api {
       // static let kEndPoint  = "http://www.omdbapi.com/?s=Batman&page"
        static let kGetRequest = "GET"
    }
    struct JsonKeys {
        static let kError        = "error"
        static let kSearch       = "Search"
        static let kTitle        = "Title"
        static let kImdbID       = "imdbID"
        static let kYear         = "Year"
        static let kType         = "Type"
        static let kPoster       = "Poster"
        static let kTotalResults = "totalResults"
        static let kResponse     = "Response"
    }

    struct ErrorMessage {
        static let kGenricErrorTitle    = "Try again!"
        static let kGenericErrorMessage = "Something went wrong. Please try again."
        static let kGenericErrorCode    = "GEC0001"
    }

    typealias CompletionBlock        = (_ result: AnyObject?   , _ error: SCError?) -> Void
}

