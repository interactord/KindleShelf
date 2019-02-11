//
//  Network.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper

protocol HasNetwork {
    var network: Networking { get }
}

protocol Networking {

    func request<T: BaseMappable>(method: NetworkMethod, url: String, parameters: [String: Any]?, type: T.Type) -> Observable<T>

    func requestList<T: BaseMappable>(method: NetworkMethod, url: String, parameters: [String: Any]?, type: T.Type) -> Observable<[T]>

    func request(method: NetworkMethod, url: String, parameters: [String: Any]?) -> Observable<Any>

    func image(url: String) -> Observable<UIImage>
}

final class Network: Networking {
    private let queue = DispatchQueue(label: "core.Network.Queue")

    func request<T: BaseMappable>(method: NetworkMethod, url: String, parameters: [String: Any]?, type: T.Type) -> Observable<T> {
        return request(method: method, url: url, parameters: parameters).map {
            if let response = Mapper<T>(context: nil, shouldIncludeNilValues: false).map(JSONObject: $0) {
                return response
            }
            throw NetworkError.incorrectDataReturned
        }

    }

    func requestList<T: BaseMappable>(method: NetworkMethod, url: String, parameters: [String: Any]?, type: T.Type) -> Observable<[T]> {
        return request(method: method, url: url, parameters: parameters).map {
            if let response = Mapper<T>(context: nil, shouldIncludeNilValues: false).mapArray(JSONObject: $0) {
                return response
            }
            throw NetworkError.incorrectDataReturned
        }
    }

    func request(method: NetworkMethod, url: String, parameters: [String: Any]?) -> Observable<Any> {
        return Observable.create { observer in
            let method = method.httpMethod()

            let request = Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseJSON(queue: self.queue) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NetworkError(error: error))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func image(url: String) -> Observable<UIImage> {
        return Observable.create { observer in
            let request = Alamofire.request(url, method: .get)
                .validate()
                .response(queue: self.queue, responseSerializer: Alamofire.DataRequest.dataResponseSerializer()) { response in
                    switch response.result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            observer.onError(NetworkError.incorrectDataReturned)
                            return
                        }
                        observer.onNext(image)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
