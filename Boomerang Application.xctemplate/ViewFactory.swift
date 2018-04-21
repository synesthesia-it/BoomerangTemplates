import UIKit
import Boomerang

fileprivate enum Storyboard : String {
    case main = "Main"
    func scene<Type:UIViewController>(_ identifier:SceneIdentifier) -> Type? {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue) as? Type
    }
}
enum SceneIdentifier : String, ListIdentifier {
    case test = "test"
    var name: String {
        return self.rawValue
    }
    var type: String? {return nil}
    
    var scene:(UIViewController & ViewModelBindableType)? {
        return Storyboard.main.scene(self) as? (UIViewController & ViewModelBindableType)
    }
}

protocol SceneViewModelType : ViewModelType {
    var sceneIdentifier:SceneIdentifier { get }
}

extension ListViewModelType {
    var listIdentifiers:[ListIdentifier] {
        return View.all()
    }
}

enum View : String, ListIdentifier {
    
    case test = "TestItemCollectionViewCell"
    static func all() -> [View] {
        return [
            .test
        ]
    }
    static func headers() -> [View] {
        return self.all().filter{ $0.type == UICollectionElementKindSectionHeader}
    }
    var isEmbeddable: Bool { return true }
    var name: String {return self.rawValue}
    var type: String? {
        switch self {
        default: return nil
            
        }
    }
}


