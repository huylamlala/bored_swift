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
}

struct ActivityServiceMock: ActivityService {
  func getActivity(with route: ActivityURLRequests) -> AnyPublisher<Result<Activity, APIError>, Never> {
    return Just<Result<Activity, APIError>>(.success(Activity.draftModel))
      .eraseToAnyPublisher()
  }
}
