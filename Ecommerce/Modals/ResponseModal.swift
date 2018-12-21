
import Foundation

class ResponseModel: NSObject, Codable {
    
    var code: Int    = WebConstants.WebServiceCodes.kErrorCode
    var msg : String    = WebConstants.WebServiceMessages.kErrorMessage
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg   = "message"
    }
    
    static func errorResponse(with message: String? = nil) -> ResponseModel  {
        
        let responseData = ResponseModel()
        responseData.code = WebConstants.WebServiceCodes.kErrorCode
        responseData.msg = message ??  WebConstants.WebServiceMessages.kErrorMessage
        if message == WebConstants.WebServiceMessages.kNoInternetResponse {
            responseData.msg = WebConstants.WebServiceMessages.kNoInternetMessage
        }
        
        return responseData
    }
    
    static func errorResponse(with code: Int? = nil, and message: String?) -> ResponseModel {
        
        let responseData = ResponseModel()
        responseData.code = code ?? WebConstants.WebServiceCodes.kErrorCode
        responseData.msg = message ??  WebConstants.WebServiceMessages.kErrorMessage
        if message == WebConstants.WebServiceMessages.kNoInternetResponse {
            responseData.msg = WebConstants.WebServiceMessages.kNoInternetMessage
        }
        return responseData
        
    }
    
    static func errorResponse(with error: Error) -> ResponseModel {
        
        let responseData = ResponseModel()
        responseData.msg = error.localizedDescription
        if error.localizedDescription == WebConstants.WebServiceMessages.kNoInternetResponse {
            responseData.msg = WebConstants.WebServiceMessages.kNoInternetMessage
        }
        return responseData
        
    }
}

