//
//  ViewFactory.swift
//  EPTA
//
//  Created by Stefano Mondino on 14/12/16.
//  Copyright © 2016 EPTA. All rights reserved.
//

import UIKit
import Boomerang

enum Storyboard : String {
    case main = "Main"
    func scene<Type:UIViewController>(_ identifier:SceneIdentifier) -> Type {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue).setup() as! Type
    }
}
enum SceneIdentifier : String, ListIdentifier {
    case test = "test"
    var name: String {
        return self.rawValue
    }
    var type: String? {return nil}
}
extension ListViewModelType {
    var listIdentifiers:[ListIdentifier] {
        return Cell.all()
    }
}

enum ActionViewIdentifier : String, ListIdentifier {
    case login = "InsertEmailView"
    case checkUpdates = "CheckUpdateView"
    case askForLogin = "AskForLoginView"
    case appUpdated = "AppIsUpdateView"
    case downloadsAvailable = "DownloadsAvailableView"
    case downloading = "DownloadInProgressView"
    
    var type: String? {return nil}
    var name: String { return self.rawValue }
}

enum CollectionViewCell : String, ListIdentifier {
    case test = "TestItemCollectionViewCell"
    static func all() -> [Cell] {
        return [
            .test
        ]
    }
    static func headers() -> [Cell] {
        return self.all().filter{ $0.type == UICollectionElementKindSectionHeader}
    }
    var name: String {return self.rawValue}
    var type: String? {
        switch self {
        case .paragraphTitle:
            return UICollectionElementKindSectionHeader
        default: return nil
            
        }
    }
}


