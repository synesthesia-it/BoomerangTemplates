//
//  ViewModelFactory.swift
//  BoomerangDemo
//
//  Created by Stefano Mondino on 12/11/16.
//  Copyright © 2016 Stefano Mondino. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import Boomerang



typealias Selection = Action<SelectionInput,SelectionOutput>
typealias HomeSelection = Action<HomeSelectionInput,HomeSelectionOutput>

enum HomeSelectionInput : SelectionInput {
    case item(IndexPath)
    case login(String)
    case cancel
    case download
    case check
    case askForCheck
    case start
    case askForLogin
    case showLogin
    
}
enum HomeSelectionOutput : SelectionOutput {
    case viewModel(ViewModelType)
    case action(ActionViewModelType)
    case exit
    case completed
}

struct ViewModelFactory {
    static func news() -> ListViewModelType {
        return NewsViewModel()
    }
    static func newsItem(fromModel model:News) -> ItemViewModelType {
        return NewsItemViewModel(model: model)
    }
    
    static func newsDetail(_ model:News) -> ListViewModelType {
        return NewsDetailViewModel(model: model)
    }
    static func newsHeader(_ model:News) -> ItemViewModelType {
        return NewsHeaderItemViewModel(model: model)
    }
    static func newsBody(_ model:News) -> ItemViewModelType {
        return NewsBodyItemViewModel(model: model)
    }
    
    static func folderItem(_ model:Folder) -> ItemViewModelType {
        return FolderItemViewModel(model: model)
    }
    // = nil se root
    static func folders(folder: Folder? = nil) -> ListViewModelType {
        return FoldersViewModel(folder:folder)
    }
    
    static func resources(fromFolder folder: Folder? = nil) -> ViewModelType {

        return ResourcesViewModel(model: folder)
    }
    static func resourceItem(_ resource: Resource) -> ItemViewModelType {
        return ResourceItemViewModel(model: resource)
    }
    
    static func mainShelf() -> ViewModelType {
        return self.shelf(withType: NONE)
    }
    static func shelf(withType type:ShelfTypes) -> ViewModelType {
        return ShelfViewModel(model: Shelf(type: type))
    }
    static func shelfProductItem(_ shelfProduct: ShelfProduct, fromShelf shelf:Shelf? = nil) -> ItemViewModelType {
        return ShelfProductItemViewModel(model: shelfProduct, fromShelf:shelf)
    }
    static func lineItem(_ line: Line, withActionBlock actionBlock:@escaping ((ShelfProduct,Line) ->())) -> ItemViewModelType {
        return LineItemViewModel(model: line, actionBlock:actionBlock)
    }
    static func pager(withLine line: Line, startingFrom product:ShelfProduct) -> ViewModelType {
        return ProductPagerViewModel(line: line, startingFromProduct: product)
    }
    static func productDetail(withProduct product:Product, shelfProduct:ShelfProduct) -> ItemViewModelType {
        return ProductDetailViewModel(withProduct: product, andShelfProduct: shelfProduct)
    }
    static func imageGallery(withProduct product:Product) -> ViewModelType {
        return ImageGalleryViewModel(withProduct: product)
    }
    static func imageGallery(withResources resources:[Resource]) -> ViewModelType {
        return ImageGalleryViewModel(withResources: resources)
    }
    static func imageGalleryItem(withImage image:UIImage?) -> ItemViewModelType {
        return ImageGalleryItemViewModel(image: image ?? UIImage())
    }
    static func targetItem(withImage image:UIImage?) -> ItemViewModelType {
        return TargetItemViewModel(image: image ?? UIImage())
    }
    static func paragraphTitleItem(withTitle title:String) -> ItemViewModelType {
        return ParagraphTitleItemViewModel(title: title)
    }
    static func informationsItem(withTitle title:String) -> ItemViewModelType {
        return InformationsItemViewModel(title: title)
    }
    static func onlyTextItem(withText text:String) -> ItemViewModelType {
        return OnlyTextItemViewModel(text: text)
    }
    static func organolepticNotesItem(withTitle title:String, description:String) -> ItemViewModelType {
        return OrganolepticNotesItemViewModel(title: title, description:description)
    }
    static func productInfoItem(withTitle title:String, description:String) -> ItemViewModelType {
        return ProductInfoItemViewModel(title: title, description:description)
    }
    static func greatVintagesItem(withImage image:UIImage?) -> ItemViewModelType {
        return GratVintagesItemViewModel(image: image ?? UIImage())
    }
    
    static func corporateResources() -> ViewModelType {
        return ResourcesViewModel(resources: Resource.corporate, withTitle:TabBarItemType.company.title ?? "", isCorporate : true)
    }
    static func corporateGallery() -> ViewModelType {
        return gallery(withImages: Resource.corporate)
    }
    static func gallery(withResource resource:Resource) -> ViewModelType {

        return self.gallery(withImages: [resource], startingFrom: resource)
        
    }
    static func gallery(withImages images:[Resource]) -> ListViewModelType {
        guard let resource = images.first else {
        
            return GalleryViewModel(images: images, startingFrom: nil)
        }
        return self.gallery(withImages: images, startingFrom: resource)
    }
    static func gallery(withImages images:[Resource], startingFrom resource:Resource ) -> ListViewModelType {
        let type = resource.filetype ?? ""
        switch type.uppercased()  {
        case "PDF": return GalleryViewModel(pdfResource: resource)
        default:  return GalleryViewModel(images: images, startingFrom: resource)
        }
 
    }
    static func image(withResource resource:Resource) -> ItemViewModelType {
        return ImageItemViewModel(model:resource)
    }
    static func pdfPage(withPage page:PDFPage) -> ItemViewModelType {
        return PDFItemViewModel(model: page)
    }
    static func home() -> ViewModelType {
        return HomeViewModel()
    }
    static func homeItem(_ model:HomeItem) -> ItemViewModelType {
        return HomeItemViewModel(model: model)
    }
    
    
    static func login(withSelection selection:HomeSelection) -> ActionViewModelType {
        return LoginViewModel(withSelection: selection)
    }
    static func checkUpdates(withSelection selection:HomeSelection) -> ActionViewModelType {
        return SimpleActionViewModel(withSelection: selection, listIdentifier: ActionViewIdentifier.checkUpdates)
    }
    static func appUpdated(withSelection selection:HomeSelection) -> ActionViewModelType {
        return SimpleActionViewModel(withSelection: selection, listIdentifier: ActionViewIdentifier.appUpdated)
    }
    static func downloadsAvailable(withSelection selection:HomeSelection) -> ActionViewModelType {
        return SimpleActionViewModel(withSelection: selection, listIdentifier: ActionViewIdentifier.downloadsAvailable)
    }
    static func askForLogin(withSelection selection:HomeSelection) -> ActionViewModelType {
        return SimpleActionViewModel(withSelection: selection, listIdentifier: ActionViewIdentifier.askForLogin)
    }
    static func download(withSelection selection:HomeSelection, downloading:Observable<DownloadProgress>) -> ActionViewModelType {
        return DownloadViewModel(withSelection: selection, downloading:downloading)
    }
    static func web(withSocial item:HomeItem) -> ViewModelType{
        return WebViewModel(withSocial: item)
    }
    static func notes(startingFrom note:Note? = nil) -> ViewModelType {
        let notes = Note.all
        return NotesViewModel(notes: notes, startingFrom: note ?? notes.first)
    }
    static func notes(startingFrom index:IndexPath) -> ViewModelType {
        let notes = Note.all
        let start =  notes[index.row]
        return NotesViewModel(notes: notes, startingFrom: start)
    }
    static func notesList() -> ViewModelType {
        let notes = Note.allWithNew
        let vm =  NotesViewModel()
        vm.identifier = Cell.note
        return vm
    }
}
