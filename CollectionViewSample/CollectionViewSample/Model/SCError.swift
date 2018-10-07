//
//  SCError.swift
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

/** This Class is used to initialize errorTitle, errorMessage and errorCode.
 ** All variables of this class is read only.
 * errortitle    :  Error Title.
 * errorCode     :  Error Code.
 * errorMessage  :  Error Message.
 *
 ** Functions *
 * Initilaize ErrorObject with errorTitle, errorCode, errorMessage. That class contains default initialization for errorTitle, errorCode , errorMessage. So three varibales cant be nil in any point of time *

 * init(error  : Error) :  That function will prepare all variables with the help of ErrorObject. i.e Apple Provided Error Object.

 */
class SCError: NSObject {
    private(set) var errortitle   : String!  = Constant.ErrorMessage.kGenricErrorTitle
    private(set) var errorCode    : String!  = Constant.ErrorMessage.kGenericErrorCode
    private(set) var errorMessage : String!  = Constant.ErrorMessage.kGenericErrorMessage

    /** init with Error Object */
    init(error  : Error?) {
        super.init()
        /** Prepare error from Error(Apple provided Error) object. */
        prepareError(errorTitle    : nil,
                     errorMessage  : error?.localizedDescription,
                     errorCode     : error == nil ? nil : String((error! as NSError).code))
    }
    private override init() {
        super.init()
    }

    /** Initializa error object with errorTitle, errorMessage, errorCode */
    init(errortitle   : String? = nil,
         errorMessage : String? = nil,
         errorCode    : String? = nil) {
        super.init()
        /** Prepare error with respective values */
        prepareError(errorTitle     : errortitle,
                     errorMessage   : errorMessage,
                     errorCode      : errorCode)
    }

    /** Initializa error object errorMessage */
    init(errorMessage : String? = nil) {
        super.init()
        /** Prepare error with respective values */
        prepareError(errorTitle     : nil,
                     errorMessage   : errorMessage,
                     errorCode      : nil)
    }

    /** Prepare error with ErrorTitle, ErrorMessage, ErrorCode */
    private func prepareError(errorTitle     : String?,
                              errorMessage   : String?,
                              errorCode      : String?){
        /* Checking for valid errorTitle */
        if (isAValidString(text: errorTitle)   == true)  {
            self.errortitle  = errorTitle
        }

        /* Checking for valid errorCode */
        if (isAValidString(text: errorCode)   == true)  {
            self.errorCode  = errorCode
        }

        /* Checking for valid errorMessage */
        if (isAValidString(text: errorMessage)   == true)  {
            self.errorMessage  = errorMessage
        }
    }

    /** Check for valid string
     * text : String need to be check.
     That function will retrun a bool value.
     */
    private func isAValidString(text : String?)-> Bool {
        if (text != nil) && text?.isEmpty == false {
            return true
        }
        return false
    }
}
