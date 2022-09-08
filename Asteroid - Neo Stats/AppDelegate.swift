//
//  AppDelegate.swift
//  Asteroid - Neo Stats
//
//  Created by Keyur on 07/09/22.
//

import UIKit
import NVActivityIndicatorView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(UInt32(2.0))
        return true
    }
    
    //MARK:- Share Appdelegate
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }


}

//MARK:- Loader
extension AppDelegate {
    func showLoader()
    {
        removeLoader()
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = false
            self.activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((self.window?.frame.size.width)!-50)/2, y: ((self.window?.frame.size.height)!-50)/2, width: 50, height: 50))
            self.activityLoader.type = .ballSpinFadeLoader
            self.activityLoader.color = DarkTextColor
            self.window?.addSubview(self.activityLoader)
            self.activityLoader.startAnimating()
        }
    }
    
    func removeLoader()
    {
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = true
            if self.activityLoader == nil {
                return
            }
            self.activityLoader.stopAnimating()
            self.activityLoader.removeFromSuperview()
            self.activityLoader = nil
        }
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
