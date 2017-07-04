import Foundation
import Boomerang
import UIKit
import MediaPlayer
import AVKit






struct Router : RouterType {
    public static func root() -> UIViewController {
        return UIViewController()
    }
        
    public static func start(_ delegate:AppDelegate) {
        
        delegate.window = UIWindow(frame: UIScreen.main.bounds)
        delegate.window?.rootViewController = self.root()
        
        delegate.window?.makeKeyAndVisible()
        
    }

    public static func rootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    public static func restart() {
        UIApplication.shared.keyWindow?.rootViewController = Router.root()
    }
   

    
    public static func from<Source> (_ source:Source, viewModel:ViewModelType) -> RouterAction where Source: UIViewController {
        switch viewModel {
        
        default:
            return EmptyRouterAction()
        }
    }

}
