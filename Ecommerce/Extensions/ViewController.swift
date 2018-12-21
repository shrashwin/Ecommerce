
import UIKit

/*
 This extension contains core methods of the uiviewcontroller to be used from app
 */

extension UIViewController {
    
   
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFrom(appStoryBoard: StoryboardType) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    func presentAsModal() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
    }
    
    func push(viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func newNavController(with rootVC: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        nav.isNavigationBarHidden = true
        return nav
    }
    
    func present(with controller: UIViewController, animated: Bool = true) {
        present(controller, animated: animated, completion: nil)
    }
    
    
    func showAlertOnMainThread(message: String = "Something went wrong.\nPlease try again later.") {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: AppInfo.appname, message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func showAlertWithOkHandler(title: String = AppInfo.appname, message: String = "Something went wrong.\nPlease try again later.", okHandler: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: AppInfo.appname, message: message, preferredStyle: .alert)
            
            let okAction =  UIAlertAction(title: "OK", style: .default){
                handler in
                okHandler?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func showAlertWithOkHandler(message: String = "Something went wrong.\nPlease try again later.", okHandler: @escaping () -> (), cancelHandler: @escaping () ->()) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: AppInfo.appname, message: message, preferredStyle: .alert)
            
            let okAction =  UIAlertAction(title: "OK", style: .default){
                handler in
                okHandler()
            }
            
            let cancelAction =  UIAlertAction(title: "Cancel", style: .default){
                handler in
                cancelHandler()
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    @objc func showHud(message: String) {
       
    }
    
    @objc func hideHud() {
        
    }
    
    @objc func popRoot() {
        hideHud()
        
    }
    
    func showCustomAlertWith(title: String, message: String, completion: (() -> Void)? = nil) {
        hideHud()
        showAlertWithOkHandler(title: title, message: message) {
            completion?()
        }
    }
    
    @objc func handleFailure(response: ResponseModel, completion: (() -> Void)? = nil) {
        
        if response.code == WebConstants.WebServiceCodes.kUserInvalidCode {
           popRoot()
        }
        else if response.code == WebConstants.WebServiceCodes.kNoDataCode  {
            showCustomAlertWith(title: AlertMessages.errorTitle, message: response.msg)
        }
        else {
            showCustomAlertWith(title: AlertMessages.errorTitle, message: response.msg) {
                completion?()
            }
        }
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
