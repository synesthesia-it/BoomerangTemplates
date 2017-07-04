//
//  Router+Utilities.swift
//  MyTest
//
//  Created by Stefano Mondino on 04/07/17.
//  Copyright © 2017 stefanomondino.com. All rights reserved.
//

import Foundation
import UIKit
import Boomerang
import AVKit
import AVFoundation

extension Router {
    public static func openApp<Source> (_ url:URL?, from source:Source) -> RouterAction
        where Source: UIViewController{
            if (url == nil) {return EmptyRouterAction()}
            
            return UIViewControllerRouterAction.custom(action: {
                UIApplication.shared.openURL(url!)
            })
            
    }
    public static func exit<Source>(_ source:Source) -> RouterAction where Source: UIViewController {
        return UIViewControllerRouterAction.custom {
            _ = source.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    public static func dismiss<Source>(_ source:Source) -> RouterAction where Source: UIViewController {
        return UIViewControllerRouterAction.custom {
            _ = source.dismiss(animated: true, completion: nil)
        }
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
