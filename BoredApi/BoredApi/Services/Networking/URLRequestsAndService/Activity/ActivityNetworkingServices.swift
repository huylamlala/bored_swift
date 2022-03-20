//
//  PeopleNetworkingServices.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/10/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import Alamofire
import Combine
import SwiftUI

struct ActivityNetworkingServices: ActivityService {
  
  var clientRequest = APIRequest()
  
  func getActivity(with route: ActivityURLRequests) -> AnyPublisher<Result<Activity, APIError>, Never> {
    clientRequest.requestObject(route: route)
  }
  
  func getExpectingActivitiesAmount() -> AnyPublisher<ExpectingActivitiesAmount, Never>{
    UserDefaults.standard.publisher(for: \.expectingActivitiesAmount)
      .map { amount in
        ExpectingActivitiesAmount(rawValue: amount) ?? .five
      }
      .eraseToAnyPublisher()
  }
  
  func getSubscribingActivityTypes() -> AnyPublisher<[ActivityType], Never> {
    UserDefaults.standard.publisher(for: \.subscribingActivityTypes)
      .map { subscribingActivityTypes in
        let results = subscribingActivityTypes.compactMap { ActivityType(rawValue: $0) }
        if results.isEmpty {
          return ActivityType.allCases
        }
        return results
      }
      .eraseToAnyPublisher()
  }
}
