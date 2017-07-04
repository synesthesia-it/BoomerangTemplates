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

class ___FILEBASENAMEASIDENTIFIER___ItemCollectionViewCell: UICollectionViewCell, ViewModelBindable {
    
    var viewModel:ItemViewModelType?
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bind(to viewModel: ViewModelType?) {
        guard let viewModel = viewModel as? ___FILEBASENAMEASIDENTIFIER___ItemViewModel else {
            return
        }
        self.viewModel = viewModel
    }
}
