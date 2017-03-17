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
    case news = "newsList"
    case newsDetail = "newsDetail"
    case folders = "folders"
    case resources = "resources"
    case shelf = "shelf"
    case productDetail = "productDetail"
    case productPager = "productPager"
    case gallery = "gallery"
    case cantina = "cantinaPrivata"
    case image = "image"
    case home = "home"
    case pdf = "pdf"
    case web = "web"
    case notes = "notes"
    case note = "note"
    case noteList = "noteList"
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
enum Decoration : String, ListIdentifier {
    case resources = "ResourcesDecorationView"
    case shelf = "ShelfDecorationView"
    case none = ""
    var name: String {return self.rawValue}
    var type: String?  {return nil}
    var height:CGFloat {
        switch self {
        case .none : return 0
        case .shelf:
            return 262.0
        default:
            return 54.0
        }
        
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

enum Cell : String, ListIdentifier {
    case news = "NewsItemCollectionViewCell"
    case newsHeader = "NewsHeaderItemView"
    case newsBody = "NewsBodyItemView"
    case folder = "FolderItemCollectionViewCell"
    case resource = "ResourceItemCollectionViewCell"
    case shelfProduct = "ShelfProductItemCollectionViewCell"
    case line = "LineItemCollectionViewCell"
    case paragraphTitle = "ParagraphTitleCollectionViewCell"
    case onlyText = "OnlyTextCollectionViewCell"
    case organolepticNotes = "OrganolepticNotesItemCollectionViewCell"
    case imageGallery = "ImageGalleryItemCollectionViewCell"
    case productInfo = "ProductInfoItemCollectionViewCell"
    case home = "HomeItemCollectionViewCell"
    case informations = "InformationsItemCollectionViewCell"
    case greatVintages = "GreatVintagesItemCollectionViewCell"
    case target = "TargetItemCollectionViewCell"
    case note = "NoteTableViewCell"
    static func all() -> [Cell] {
        return [
            .news,
            .newsHeader,
            .newsBody,
            .folder,
            .resource,
            .line,
            .paragraphTitle,
            .onlyText,
            .organolepticNotes,
            .imageGallery,
            .productInfo,
            .home,
            .informations,
            .greatVintages,
            .target,
            .shelfProduct,
            
            
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

enum View: String {
    case filtersView = "FiltersView"
    var loadView:UIView?  {
        return Bundle.main.loadNibNamed(self.rawValue, owner: nil, options: nil)?.first as? UIView
    }
    
}

extension Cell {
    func cell<T:UICollectionViewCell>() -> T {
        return UINib(nibName: self.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
}
