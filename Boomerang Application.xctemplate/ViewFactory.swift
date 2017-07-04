import UIKit
import Boomerang

enum Storyboard : String {
    case main = "Main"
    func scene<Type:UIViewController>(_ identifier:SceneIdentifier) -> Type {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue).setup() as! Type
    }
}
enum SceneIdentifier : String, ListIdentifier {
    case test = "test"
    var name: String {
        return self.rawValue
    }
    var type: String? {return nil}
}
extension ListViewModelType {
    var listIdentifiers:[ListIdentifier] {
        return CollectionViewCell.all()
    }
}

enum CollectionViewCell : String, ListIdentifier {
    
    case test = "TestItemCollectionViewCell"
    static func all() -> [CollectionViewCell] {
        return [
            .test
        ]
    }
    static func headers() -> [CollectionViewCell] {
        return self.all().filter{ $0.type == UICollectionElementKindSectionHeader}
    }
    var name: String {return self.rawValue}
    var type: String? {
        switch self {
        default: return nil
            
        }
    }
}


