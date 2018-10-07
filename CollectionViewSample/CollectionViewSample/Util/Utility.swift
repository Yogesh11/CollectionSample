//
//  Utility.swift
//  ShareChat
//
//  Created by Yogesh on 7/29/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class Utility: NSObject {
    static func showAlert(error : SCError) {
     let alertController  = UIAlertController.init(title: error.errortitle, message: error.errorMessage, preferredStyle: .alert)
        let appDelegate  = UIApplication.shared.delegate as? AppDelegate
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
