import UIKit

extension String {
    
    func getRange(of substring:String) -> NSRange {
        return (self as NSString).range(of: substring, options: .caseInsensitive)
    }
    
    func floatValue() -> Float? {
        if let floatVal = Float(self) {
            return floatVal
        }
        return nil
    }
    
    func intValue() -> Int? {
        if let intVal = Int(self) {
            return intVal
        }
        return nil
    }
    
    func CGFloatValue() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }
    
    func underlined(withColor: UIColor) -> NSMutableAttributedString? {
        
        var attributedText = NSMutableAttributedString(string: self)
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor : withColor
        ]
        attributedText = NSMutableAttributedString(string: self, attributes: attributes)
        return attributedText
    }
    
    func sliced(from: String? = "$", to: String? = "/") -> String? {
        
        return (range(of: from ?? "$")?.upperBound).flatMap { substringFrom in
            (range(of: to ?? "/", range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func getCleanUrlString() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    func getCleanedUrl() -> URL? {
        return URL(string: self.getCleanUrlString())
    }
    
}

extension StringProtocol {
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
}
