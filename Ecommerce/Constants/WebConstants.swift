
import Foundation

struct WebConstants {
    
    struct WebServiceCodes {
        
        static let kSuccessCode     = 1
        static let kNoDataCode      = 2
        static let kAuthInvalidCode = 9
        static let kUserInvalidCode = 8
        static let kErrorCode       = 0
        
    }
    
    struct WebServiceMessages {
        
        static let kErrorMessage        = "There seems to be some problem. Please try again."
        static let kNoInternetMessage   = "Make sure your device is connected to the internet."
        static let kNoInternetResponse  = "The Internet connection appears to be offline."
        
    }
    
    struct WebServiceParams {
        
        static let kAuthorizationKey                = "Authorization"
        static let kContentTypeKey                  = "Content-Type"
        static let kContentTypeJsonValue            = "Application/json"
        static let kContentTypeMultipartValue       = "multipart/form-data"
        
    }
    
}
