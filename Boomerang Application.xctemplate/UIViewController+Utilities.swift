//
//  UIViewController+Utilities.swift
//  MyTest
//
//  Created by Stefano Mondino on 04/07/17.
//  Copyright © 2017 stefanomondino.com. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Boomerang
import MBProgressHUD
import pop
import Action
import SpinKit
import Localize_Swift

protocol Collectionable {
    var collectionView:UICollectionView! {get}
    func setupCollectionView()
}
extension Collectionable where Self : UIViewController {
    func setupCollectionView() {
        self.collectionView.backgroundColor = .clear
    }
}

extension UIViewController {
    func withNavigation() -> NavigationController {
        return NavigationController(rootViewController: self)
    }
}

extension ViewModelBindable where Self : UIViewController {
    func withViewModel(_ viewModel:ViewModelType) -> Self {
        self.bind(to:viewModel, afterLoad: true)
        return self
    }
}

extension UIViewController {
    
    private struct AssociatedKeys {
        static var loaderCount = "loaderCount"
        static var disposeBag = "vc_disposeBag"
    }
    
    public var disposeBag: DisposeBag {
        var disposeBag: DisposeBag
        
        if let lookup = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
            disposeBag = lookup
        } else {
            disposeBag = DisposeBag()
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, disposeBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        return disposeBag
    }
    
    
    func setup(with viewModel:ViewModelType) -> UIViewController {
        let closure = {[unowned self] in
            (self as? Collectionable)?.setupCollectionView()
            
            if let selection = (viewModel as? SelectableViewModelType)?.selection {
                (self as? SelectableViewController)?.bind(to: selection)
            }
            
            (self as? ViewModelBindableType)?.bind(to: viewModel)
            
            if ((self.navigationController?.viewControllers.count ?? 0) > 1) {
                _ = self.withBackButton()
            }
            
        }
        if (self.isViewLoaded) {
            closure()
        }
        else {
            _ = self.rx
                .methodInvoked(#selector(viewDidLoad))
                .take(1)
                //.delay(0.0, scheduler: MainScheduler.instance)
                .subscribe(onNext:{_ in closure()})
        }
        
        return self
    }
    
    
    @objc func back() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    func withBackButton() -> UIViewController {
        let item = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = item
        return self
    }
    
    
    private var loaderCount:Int {
        
        get { return objc_getAssociatedObject(self, &AssociatedKeys.loaderCount) as? Int ?? 0}
        set { objc_setAssociatedObject(self, &AssociatedKeys.loaderCount, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
        
    }
    
    func loaderView() -> UIView {
        return RTSpinKitView(style: .stylePulse, color: UIColor.red, spinnerSize: 44)
    }
    func loaderContentView() -> UIView {
        return self.navigationController?.view ?? self.view
    }
    func showLoader() {
        
        if (self.loaderCount == 0) {
            DispatchQueue.main.async {[unowned self] in
                let hud = MBProgressHUD.showAdded(to: self.loaderContentView(), animated: true)
                let spin = self.loaderView()
                hud.customView = spin
                hud.mode = .customView
                hud.bezelView.color = .white
                hud.tintColor = .red
                hud.contentColor = .red
            }
            
        }
        self.loaderCount += 1
        
    }
    func hideLoader() {
        DispatchQueue.main.async {[weak self]  in
            if (self == nil) {
                return
            }
            self!.loaderCount = max(0, (self!.loaderCount ) - 1)
            if (self!.loaderCount == 0) {
                MBProgressHUD.hide(for: self!.loaderContentView(), animated: true)
            }
        }
        
    }

    
}
