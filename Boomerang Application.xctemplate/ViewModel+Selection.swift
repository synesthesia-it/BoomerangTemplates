import RxSwift
import Action
import UIKit
import Boomerang

enum SelectionInput : Boomerang.SelectionInput {
    case start
    case model(ModelType)
    case viewModel(ViewModelType)
    case item(IndexPath)
    case invalidateLayout
}

enum SelectionOutput : Boomerang.SelectionOutput {
    case viewModel(ViewModelType)
    case reload
    case restart
    case invalidateLayout
    case openURL(URL)
}

typealias Selection = Action<SelectionInput,SelectionOutput>

protocol SelectableViewModelType : ViewModelType  {
    var selection : Selection { get }
}

extension SelectableViewModelType {
    func generateSelection() -> Selection {
        return Selection {[weak self] input in
            switch input {
            
            default:
                return .empty()
            }
        }
    }
}

