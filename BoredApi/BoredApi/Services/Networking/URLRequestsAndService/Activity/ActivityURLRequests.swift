//
//  PeopleURLRequests.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/10/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import Alamofire

enum ActivityURLRequests: RouterURLRequestConvertible, Equatable {
  case getActivity(type: ActivityType)
    
    var method: HTTPMethod {
        switch self {
        case .getActivity:
            return .get
        }
    }
    
    var path: String {
        return "activity"
    }
    
    var parameters: Parameters? {
        switch self {
        case .getActivity(let type):
            return ["type": type]
        }
    }
}
