//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import RxSwift
import RxCocoa
import Boomerang


class ___FILEBASENAMEASIDENTIFIER___sViewController : UIViewController, ViewModelBindable, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: StackableScrollView!
    var viewModel: ___FILEBASENAMEASIDENTIFIER___sViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bind(to viewModel: ViewModelType?) {
        guard let viewModel = viewModel as? ___FILEBASENAMEASIDENTIFIER___sViewModel else {
            return
        }
        
        self.viewModel = viewModel
        self.scrollView.bind(to:viewModel)
        self.scrollView.delegate = self
        viewModel.selection.elements.subscribe(onNext:{ selection in
            switch selection {
            case .viewModel(let viewModel):
                Router.from(self,viewModel: viewModel).execute()
            }
        }).disposed(by:self.disposeBag)
        viewModel.reload()
    }
    
    
}
