
import Foundation

struct UrlConstants {
    
    static let url                              = "http://***.***.**.***/api/"
    static let baseUrl                          = UrlConstants.url
    static let versionUrl                       = ""
    static let sampleJsonBlobUrl = "https://jsonblob.com/api/15774da2-0530-11e9-9355-6f4e0aecf8a2"
    struct Policy {
        
        static let tosUrl                       = ""
        static let privacyPolicyUrl             = ""
        
    }
    
    struct Account {
        
        static let accountBaseUrl               = UrlConstants.baseUrl + UrlConstants.versionUrl
        
        static let signUpUrl                    = Account.accountBaseUrl + "register/"
        static let loginUrl                     = Account.accountBaseUrl + "login/"
        
        static let forgotPasswordUrl            = Account.accountBaseUrl + "reset-password/"
        static let changePasswordUrl            = Account.accountBaseUrl + "change-password/"
        
    }
    
    struct GoogleAPI {
        
        static let kReverseGoogleId         = ""
        static let kClientID                = ""
        static let apiKey                   = ""
        static let kReverseGeocodeUrl       = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
        static let kGeocodeUrl              = "https://maps.googleapis.com/maps/api/geocode/json?address="
        static let kAutoAddressSearchUrl    = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
        
    }
    
    struct FacebookAPI {
        static let kFacebookScheme = ""
    }
    
}
