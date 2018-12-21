import UIKit

enum ImageConstants: String {
    case appLogo
    
    var uiImage: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
