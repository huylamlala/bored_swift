//
//  APIRequest.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/9/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import Alamofire
import Combine

class APIRequest {
  private var sessionManager: Alamofire.Session
  
  init() {
    let configuration = URLSessionConfiguration.default
    
    sessionManager = Alamofire.Session(configuration: configuration)
  }
  
  deinit {
    sessionManager.session.invalidateAndCancel()
  }

  func requestObject<DecodableType: Decodable>(
    route: URLRequestConvertible
  ) -> AnyPublisher<Result<DecodableType, APIError>, Never> {
    sessionManager
      .request(route)
      .publishDecodable(type: DecodableType.self)
      .result()
      .map { result -> Result<DecodableType, APIError> in
        switch result {
        case .success(let object):
          return .success(object)
        case .failure(let error):
          return .failure(.custom(message: error.localizedDescription))
        }
      }
      .eraseToAnyPublisher()
  }
}
