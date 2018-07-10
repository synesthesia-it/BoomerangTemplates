import Moya
import RxSwift
import Gloss
enum API: TargetType {
    
    case example
    var baseURL: URL {
        switch self {
        default : return URL(string: "https://mes.streetmarket360.com/rest/api/v1/")!
        }
    }
    
    var path: String {
        switch self {
        case .example : return "example"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        default :  return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8) ?? Data()
    }
    
    var task: Task {
        switch self.method {
        case .get : return Task.requestParameters(parameters: parameters, encoding: URLEncoding.methodDependent)
        case .post, .patch, .put : return Task.requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default : return Task.requestPlain
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        default : return [:]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

class DataManager : ReactiveCompatible {
    static let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
}

fileprivate extension Observable where Element : Response {
    func mapResponseError() -> Observable<Response> {
        
        return self.flatMap { response -> Observable<Response> in
            do {
                let filtered = try response.filterSuccessfulStatusAndRedirectCodes()
                return Observable<Response>.just(filtered)
            } catch let error {
                if let moyaError = error as? MoyaError,
                    let response = moyaError.response {
                    
                    if let json = try? response.mapJSON() as? JSON,
                        let message = json?["message"] as? String {
                        return .error(APPError.message(message))
                    }
                    
                    switch response.statusCode {
                    
                    default : return .error(APPError.undefined)
                    }
                }
                return .error(error)
            }
            
        }
    }
}

extension Reactive where Base: DataManager {
    private static func request(_ token: API) -> Observable<Response> {
        return DataManager.provider
            .rx
            .request(token)
            .asObservable()
            .mapResponseError()
    }
    private static func request<T: JSONDecodable>(_ token: API, keyPath: String? = nil) -> Observable<T> {
        guard let keyPath = keyPath else {
            return request(token).mapObject(type: T.self)
        }
        return request(token).mapObject(type: T.self, forKeyPath: keyPath)
    }
    private static func request<T: JSONDecodable>(_ token: API, keyPath: String? = nil) -> Observable<[T]> {
        guard let keyPath = keyPath else {
            return request(token).mapArray(type: T.self)
        }
        return request(token).mapArray(type: T.self, forKeyPath: keyPath)
    }
    
}
