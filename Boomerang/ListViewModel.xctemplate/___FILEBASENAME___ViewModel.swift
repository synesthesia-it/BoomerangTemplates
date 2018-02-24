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
import Action

final class ___VARIABLE_productName:identifier___ViewModel : ListViewModelType {
    var dataHolder: ListDataHolderType = ListDataHolder()
    
    func itemViewModel(fromModel model: ModelType) -> ItemViewModelType? {
        guard let item = model as? ___VARIABLE_productName:identifier___ else {
            return nil
        }
        return ViewModelFactory.___VARIABLE_productName:identifier___Item(model:model)
    }
    
    lazy var selection : Selection = Selection { input in
        switch input {
        case .item(let indexPath):
            guard let model = (self.model(atIndex:indexPath) as? ___VARIABLE_productName:identifier___) else {
                return .empty()
            }
            let destinationViewModel = ViewModelFactory.nextViewModel(model:model)
            return .just(.viewModel(destinationViewModel))
        }
    }
    
    
    init() {
        
    }
}
