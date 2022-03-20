//
//  ActivitiesListViewModel.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import Combine

class ActivitiesListViewModel: ObservableObject {
  enum ViewStates: Equatable {
    case initial
    case activitiesLoaded([Activity])
    case error(APIError)
    case loading
  }
  
  var activityService: ActivityService!
  @Published var state: ViewStates = .initial
  private var cancellableSet: Set<AnyCancellable> = []
  
  func getActivities(type: ActivityType, numberOfResult: Int) {
    state = .loading
    var activities: [Activity] = []
    var upstreams: [AnyPublisher<Result<Activity, APIError>, Never>] = []
    for _ in 1...numberOfResult {
      upstreams.append(activityService.getActivity(with: .getActivity(type: type)))
    }

    Publishers.ZipMany(upstreams)
      .sink { [weak self] results in
        for result in results {
          switch result {
          case .success(let activity):
            activities.append(activity)
          case .failure(let error):
            self?.state = .error(error)
            return
          }
        }
        self?.state = .activitiesLoaded(activities.sorted(by: {
          $0.accessibility < $1.accessibility
        }))
        
      }
      .store(in: &cancellableSet)
  }
}
