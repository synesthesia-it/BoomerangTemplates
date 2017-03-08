//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Foundation
import RxSwift
import Boomerang

enum ___FILEBASENAMEASIDENTIFIER___SelectionInput : SelectionInput {
    case item(IndexPath)
}
enum ___FILEBASENAMEASIDENTIFIER___SelectionOutput : SelectionOutput {
    case viewModel(ViewModelType)
}

final class ___FILEBASENAMEASIDENTIFIER___ViewModel : ListViewModelType, ViewModelTypeSelectable {
    var dataHolder: ListDataHolderType = ListDataHolder()
    
    func itemViewModel(fromModel model: ModelType) -> ItemViewModelType? {
        guard let item = model as? ___FILEBASENAMEASIDENTIFIER___ else {
            return nil
        }
        return ViewModelFactory.__proper_factory_method_here()
    }
    
    lazy var selection = Action<___FILEBASENAMEASIDENTIFIER___SelectionInput,___FILEBASENAMEASIDENTIFIER___SelectionOutput> { input in
        switch input {
        case .item(let indexPath):
            guard let model = (self.model(atIndex:indexPath) as? ___FILEBASENAMEASIDENTIFIER___) else {
                return .empty()
            }
            let destinationViewModel = __proper_factory_method_here__
            return .just(.viewModel(destinationViewModel))
        }
    }
    
    
    init() {
        
    }
}
