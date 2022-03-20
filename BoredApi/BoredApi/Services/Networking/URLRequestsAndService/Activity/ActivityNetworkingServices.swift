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
        return results
      }
      .eraseToAnyPublisher()
  }
  
  func subscribeActivityType(_ activityType: ActivityType) {
    let key = Constants.UserDefaultsKeys.subscribingActivityTypes.rawValue
    var activityTypes = UserDefaults.standard.value(forKey: key) as? [String] ?? []
    activityTypes.append(activityType.rawValue)
    UserDefaults.standard.setValue(activityTypes, forKey: key)
  }
  
  func unsubscribeActivityType(_ activityType: ActivityType) {
    let key = Constants.UserDefaultsKeys.subscribingActivityTypes.rawValue
    let activityTypes = (UserDefaults.standard.value(forKey: key) as? [String])?
      .filter({ $0 != activityType.rawValue })
    UserDefaults.standard.setValue(activityTypes, forKey: key)
  }
  
  func setExpectingActivitiesAmount(_ expectingActivitiesAmount: ExpectingActivitiesAmount) {
    let key = Constants.UserDefaultsKeys.expectingActivitiesAmount.rawValue
    UserDefaults.standard.setValue(expectingActivitiesAmount.rawValue, forKey: key)
  }
}
