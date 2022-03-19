//
//  PeopleNetworkingServices.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/10/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import Alamofire
import Combine

struct ActivityNetworkingServices: ActivityService {
    var clientRequest = APIRequest()

    func getActivity(with route: ActivityURLRequests) -> AnyPublisher<Result<Activity, APIError>, Never> {
        clientRequest.requestObject(route: route)
    }
}
