import Foundation
import Boomerang
import UIKit
import SafariServices
import MediaPlayer
import AVKit

@available(iOS 9.0, *)
extension SFSafariViewController {
    class func canOpenURL(URL: URL) -> Bool {
        return URL.host != nil && (URL.scheme == "http" || URL.scheme == "https")
    }
}


extension Router {
    public static func open<Source> (_ url:URL?, from source:Source) -> RouterAction
        where Source: UIViewController{
            if (url == nil) {return EmptyRouterAction()}
            if (!SFSafariViewController.canOpenURL(URL:url!)) {
                return UIViewControllerRouterAction.custom(action: {
                    UIApplication.shared.openURL(url!)
                })
            }
            let vc = SFSafariViewController(url: url!, entersReaderIfAvailable: true)
            return UIViewControllerRouterAction.modal(source: source, destination: vc, completion: nil)
    }


}
