

import Foundation
import UIKit

enum ColorConstants: String {
    
    case darkBluishBlack      = "#232938"
    
    var uiColor: UIColor {
        return UIColor.colorWith(string: self.rawValue)
    }
    
}

struct ColorOption {
    struct View {
        static let border: UIColor   = ColorConstants.darkBluishBlack.uiColor
    }
    
    struct Label {
    }
    
    struct Form {
    }
    
    struct Button {
    }
    
}
