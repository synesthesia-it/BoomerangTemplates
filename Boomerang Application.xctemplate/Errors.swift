

import Foundation
import Action
import RxSwift

extension ObservableType where E == ActionError {
    func unwrap() -> Observable<APPError?> {
        return self.map {
            switch $0 {
            case .underlyingError(let error): return error as? APPError
            default: return nil
            }
        }
    }
}

enum APPError : Swift.Error {
    case undefined
    case message(String)
    var title :String {
        switch self {
        default : return "Error"
        }
        
    }
    var message:String {
        switch self {
        case .message(let message) : return message
        default :  return "Error"
        }
        
    }
}
