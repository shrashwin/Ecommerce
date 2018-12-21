import  UIKit
import CoreLocation

enum FeebackType {
    
    case impact
    case notification
    case selection
}

class Helper: NSObject {
    
    static func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func getLocalizedString(forText: String) -> String {
        return NSLocalizedString(forText, comment: "")
    }
    
    static func updateOffsetHeight() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436, 2688, 1792:
                // 2436 -> iphone x and xs
                //2688 -> iphone xsmax
                //1792 -> iphone xr
                offsetHeight = 44.0
            default:
                Helper.printMessage("unknown")
            }
        }
    }
    
    static func getUniqueId(with email: String?) -> String? {
        guard let email = email else { return nil }
        return "\(email.hashValue)"
    }
    
    static func convertDeviceTokenToString(deviceToken: NSData) -> String {
        
        var deviceTokenStr = deviceToken.description.replacingOccurrences(of: ">", with: "", options: .caseInsensitive, range: nil)
        deviceTokenStr = deviceTokenStr.replacingOccurrences(of: "<", with: "", options: .caseInsensitive, range: nil)
        deviceTokenStr = deviceTokenStr.replacingOccurrences(of: " ", with: "", options: .caseInsensitive, range: nil)
        return deviceTokenStr
        
    }
    
    static func setDeviceToken(token: String?) {
        
        if let deviceToken = token {
            
            do {
                if #available(iOS 11.0, *) {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: deviceToken, requiringSecureCoding: true)
                    UserDefaults.standard.setValue(data, forKey: "DEVICETOKEN")
                    UserDefaults.standard.synchronize()
                
                } else {
                    
                }
            }
            catch {
                Helper.printMessage("error")
            }
            
        }
        
    }
    
    static func getDeviceToken() -> String? {
        
        if let data = UserDefaults.standard.value(forKey: "DEVICETOKEN") {
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? String
            }
            catch {
                return nil
            }
        }
        
        return nil
        
    }
    
    static func setUserInfo( userinfo: UserInfo?) {
        
        if let info = userinfo {
            
            do {
                if #available(iOS 11.0, *) {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: true)
                    UserDefaults.standard.setValue(data, forKey: "USERINFO")
                    UserDefaults.standard.synchronize()
                } else {
                    // Fallback on earlier versions
                }
            }
            catch {
                Helper.printMessage("error")
            }
        }
        else {
            UserDefaults.standard.setValue(nil, forKey: "USERINFO")
        }
        UserDefaults.standard.synchronize()
        
    }
    
    
    static func getUserInfo() -> UserInfo? {
        
        if let data = UserDefaults.standard.value(forKey: "USERINFO") {
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? UserInfo
            }
            catch {
                return nil
            }
        }
        return nil
        
    }
    
    static func getHeader() -> [String:String]? {
        
        guard let authKey = Helper.getUserInfo()?.authKey else {
            return nil
        }
        if authKey.isEmpty {
            return nil
        }
        return [WebConstants.WebServiceParams.kAuthorizationKey : "Token \(authKey)"]
        
    }
    
    static func isValidAuthKey() -> Bool? {
        
        return true
        
    }
    
    static func getSampleParameters() -> [String:String] {
        
        return ["test" : "test"]
        
    }
    
    static func getInValidUserResponse() -> ResponseModel {
        return ResponseModel.errorResponse(with: WebConstants.WebServiceCodes.kUserInvalidCode, and: HudMessages.userNotLoggedIn)
    }
    
    static func getInValidAuthResponse() -> ResponseModel {
        return ResponseModel.errorResponse(with: WebConstants.WebServiceCodes.kAuthInvalidCode, and: HudMessages.authKeyNotValid)
    }
    
    static func jsonSerializationError() -> ResponseModel {
        return ResponseModel.errorResponse(with: WebConstants.WebServiceCodes.kErrorCode, and: HudMessages.jsonSerializationError)
    }
    
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            Helper.printMessage("------------------------------")
            Helper.printMessage("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            Helper.printMessage("Font Names = [\(names)]")
        }
    }
    
    static func printMessage(_ message: String) {
        
        if AppInfo.isDebug {
            print(message)
        }
    }
    
    static func validateApiCall(validateAuth:Bool = true, validateHeader: Bool = true) -> ResponseModel? {
        
        let validAuth = Helper.isValidAuthKey() ??  false
        var validHeader = false
        
        if let _ = Helper.getHeader() {
            validHeader = true
        }
        
        if validateAuth && validateHeader {
            if validAuth && validHeader {
                return nil
            }
            else if validAuth {
                return Helper.getInValidUserResponse()
            }
            return Helper.getInValidAuthResponse()
        }
        else if validateAuth {
            return validAuth ? nil : Helper.getInValidAuthResponse()
        }
        else if validateHeader {
            return validHeader ? nil : Helper.getInValidUserResponse()
        }
        return nil
        
    }
    
    static func getApplicationWindow() -> UIWindow? {

        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window {
            return window
        }
        
        return nil
    }
    
    static func generateFeeback(of type: FeebackType = .impact) {
        
        switch type {
        case .impact:
            
            let impactFeedback = UIImpactFeedbackGenerator()
            impactFeedback.impactOccurred()
            
        default:
            break
        }
    }
    
}


