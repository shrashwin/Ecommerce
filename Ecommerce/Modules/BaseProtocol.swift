import Foundation

/// Protocol methods to be inherited by each view protocol of all module
@objc protocol BaseProtocol: class {
    
    func showHud(message: String)
    func hideHud()
    /// Handles the response modal from api call
    ///
    /// - Parameter response: response modal with code and message to be handled
    func handleFailure(response: ResponseModel, completion: (() -> Void)?)
    
}

// MARK: - Extension of base protocol method so as to overide it over in view controller extension
extension BaseProtocol {
    
    
    func showHud(message: String) {}
    func hideHud() {}
    func handleFailure(response: ResponseModel, completion: (() -> Void)? = nil) {}
    
}

