//
//  ActivityBoardViewModel.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Combine

class ActivityBoardViewModel: ObservableObject {
  enum ViewStates: Equatable {
    case initial
    case loading
    case loaded
  }
  
  @Published var state: ViewStates = .initial
  @Published var expectingActivitiesAmount: ExpectingActivitiesAmount = .five
  @Published var subscribingActivityTypes = ActivityType.allCases
  private var cancellableSet: Set<AnyCancellable> = []
  var activityService: ActivityService!
  
  func setupBinding() {
    state = .loading
    activityService.getExpectingActivitiesAmount()
      .sink { [weak self] in self?.expectingActivitiesAmount = $0 }
      .store(in: &cancellableSet)
    activityService.getSubscribingActivityTypes()
      .sink { [weak self] in self?.subscribingActivityTypes = $0 }
      .store(in: &cancellableSet)
    state = .loaded
  }
}
