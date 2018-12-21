

import Foundation


class UserInfo: NSObject, Codable {
    
    var id:             Int?
    var name:           String?
    var profileImage:   String?
    var authKey:        String?
    var deviceId:       String?
    var pushToken:      String?
    var isFirstLogin:   Bool?
    var loginType:       Int?
    
    override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case authKey = "auth_token"
        case deviceId   = "device_id"
        case pushToken  = "push_notification_token"
        case isFirstLogin  = "is_first_login"
    }
    
}
