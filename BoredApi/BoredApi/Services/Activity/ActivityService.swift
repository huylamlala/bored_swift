//
//  ActivityService.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import Foundation
import Combine

protocol ActivityService {
  func getActivity(with route: ActivityURLRequests) -> AnyPublisher<Result<Activity, APIError>, Never>
  func getSubscribingActivityTypes() -> AnyPublisher<[ActivityType], Never>
  func getExpectingActivitiesAmount() -> AnyPublisher<ExpectingActivitiesAmount, Never>
  
  func subscribeActivityType(_ activityType: ActivityType)
  func unsubscribeActivityType(_ activityType: ActivityType)
  func setExpectingActivitiesAmount(_ expectingActivitiesAmount: ExpectingActivitiesAmount)
}

struct ActivityServicePreview: ActivityService {
  func getSubscribingActivityTypes() -> AnyPublisher<[ActivityType], Never>  {
    return Just([.education, .busywork, .charity]).eraseToAnyPublisher()
  }
  
  func getExpectingActivitiesAmount() -> AnyPublisher<ExpectingActivitiesAmount, Never> {
    return Just(.four).eraseToAnyPublisher()
  }
  
  func getActivity(with route: ActivityURLRequests) -> AnyPublisher<Result<Activity, APIError>, Never> {
    return Just<Result<Activity, APIError>>(.success(Activity.draftModel))
      .eraseToAnyPublisher()
  }
  
  func subscribeActivityType(_ activityType: ActivityType) {}
  
  func unsubscribeActivityType(_ activityType: ActivityType) {}
  
  func setExpectingActivitiesAmount(_ expectingActivitiesAmount: ExpectingActivitiesAmount) {}
}
