//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import Boomerang
import RxSwift
import Action
import RxCocoa

class ___VARIABLE_productName:identifier___ItemView: UIView, ViewModelBindable, EmbeddableView {
    
    var viewModel:ItemViewModelType?
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bind(to viewModel: ViewModelType?) {
        guard let viewModel = viewModel as? ___VARIABLE_productName:identifier___ItemViewModel else {
            return
        }
        self.viewModel = viewModel
    }
}
