import Foundation
import Boomerang
import UIKit
import MediaPlayer
import AVKit


internal extension UIViewController {
    func withNavigation() -> NavigationController {
        return NavigationController(rootViewController: self)
    }
}

 extension ViewModelBindable where Self : UIViewController {
    func withViewModel(_ viewModel:ViewModelType) -> Self {
        self.bindTo(viewModel:viewModel, afterLoad: true)
        return self
    }
}

struct Router : RouterType {
    
    public static func exit<Source>(_ source:Source) where Source: UIViewController{
        _ = source.navigationController?.popToRootViewController(animated: true)
    }
    
    public static func dismiss<Source>(_ source:Source) where Source: UIViewController{
        _ = source.dismiss(animated: true, completion: nil)
    }
    
    public static func start(_ delegate:AppDelegate) {
        
        delegate.window = UIWindow(frame: UIScreen.main.bounds)
        delegate.window?.rootViewController = self.root()
        
        delegate.window?.makeKeyAndVisible()
        
    }
    
    public static func confirm<Source:UIViewController>(title:String,message:String,confirmationTitle:String, from source:Source, action:@escaping ((Void)->())) -> RouterAction {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: confirmationTitle, style: .default, handler: {_ in action()}))
        return UIViewControllerRouterAction.modal(source: source, destination: alert, completion: nil)
    }
    
    public static func actions<Source:UIViewController>(fromSource source:Source, item:UIBarButtonItem, actions:[UIAlertAction]) -> RouterAction {
        let alert = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        
        _ = actions.reduce(alert) { (accumulator, action)  in
            accumulator.addAction(action)
            
            return accumulator
        }
        alert.modalPresentationStyle = .popover
        let popover = alert.popoverPresentationController!
        popover.permittedArrowDirections = .up
        popover.barButtonItem = item
        return UIViewControllerRouterAction.modal(source: source, destination: alert, completion: nil)
        
    }

    
    public static func from<Source> (_ source:Source, viewModel:ViewModelType) -> RouterAction where Source: UIViewController {
        switch viewModel {
        
        default:
            return EmptyRouterAction()
        }
    }

    

    public static func root() -> UIViewController {
        return UIViewController()
    }
    
    
    public static func rootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    public static func restart() {
        UIApplication.shared.keyWindow?.rootViewController = Router.root()
    }

    public static func openApp<Source> (_ url:URL?, from source:Source) -> RouterAction
        where Source: UIViewController{
            if (url == nil) {return EmptyRouterAction()}
            
            return UIViewControllerRouterAction.custom(action: {
                UIApplication.shared.openURL(url!)
            })
            
    }
    
    public static func playVideo<Source> (_ url:URL?, from source:Source) -> RouterAction
        where Source: UIViewController{
            guard let urlFormatted:URL = URL(string:url?.absoluteString.removingPercentEncoding ?? "") else {
                return EmptyRouterAction()
            }

            let playerController = AVPlayerViewController()
            let asset:AVURLAsset = AVURLAsset(url: urlFormatted, options: [:])

            return UIViewControllerRouterAction.modal(source: source, destination: playerController, completion: {
                let playerItem:AVPlayerItem =  AVPlayerItem(asset: asset)
                playerController.player = AVPlayer(playerItem: playerItem)
                playerController.player?.play()
            })
    }
}
