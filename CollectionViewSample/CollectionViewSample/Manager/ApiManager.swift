//
//  ApiManager.swift
//
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

/** This class is used to call apis*/
class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    private lazy var sessionManager: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = nil
        /*The timeout interval to use when waiting for additional data. The timer associated with this value is reset whenever new data arrives. When the request timer reaches the specified interval without receiving any new data, it triggers a timeout.*/
        sessionConfig.timeoutIntervalForRequest = TimeInterval(30)
        /*The maximum amount of time that a resource request should be allowed to take. This value controls how long to wait for an entire resource to transfer before giving up. The resource timer starts when the request is initiated and counts until either the request completes or this timeout interval is reached, whichever comes first.*/
        sessionConfig.timeoutIntervalForResource = TimeInterval(60)
        return  URLSession(configuration: sessionConfig) //URLSessionConfiguration.default
    }()

    private override init() {
        super.init()
    }

    func getDataForPage(_number : Int , onCompletion : @escaping Constant.CompletionBlock) {
        let url = "https://www.omdbapi.com/?s=Batman&page=" + String(_number) + "&apikey=eeefc96f"
        let request = makeRequest(url: url, methodType: Constant.Api.kGetRequest)
        makeTask(request: request, onCompletion: onCompletion)
    }
    /** makeRequest         : makeRequest for an api.
     * url            : api url.
     * completionBlock: completionBlock which will contain errorObj and json.
     */
    private func makeRequest(url : String, methodType : String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = methodType
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    /** makeTask      : makeTask for an api.
     * url            : api url.
     * completionBlock: completionBlock which will contain errorObj and json.
     */
    private func makeTask(request : URLRequest, onCompletion : @escaping Constant.CompletionBlock) {
        sessionManager.dataTask(with: request) { (data, response, error) in
            guard let data  = data , error == nil else{
                onCompletion(nil, self.prepareError(error: error))
                return
            }
            do {
                let json =  try JSONSerialization.jsonObject(with: data)
                if let responseJson  =  json as? [String : Any] , (responseJson[Constant.JsonKeys.kResponse] as? String) == "True"{
                    onCompletion(responseJson as AnyObject, nil)
                } else{
                    onCompletion(nil, self.prepareError(error: error))
                }
            }
            catch {
                onCompletion(nil, self.prepareError(error: error))
            }
            }.resume()
    }

    /** prepareError      : Prepare error.
     * error           : an error object to intialize SCError object.
     */
    private func prepareError(error : Error?) -> SCError{
        return SCError(error: error)
    }

    /** prepareErrorWithMessage : Prepare error with proper message.
     * errorMessage      : An instance of string. It will be used to show an popup on the screen.
     */
    private func prepareErrorWithMessage(errorMessage : String?) -> SCError {
        return SCError(errorMessage: errorMessage)
    }
}

