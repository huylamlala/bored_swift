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
  @Published var presentingSettings = false
  private var cancellableSet: Set<AnyCancellable> = []
  var activityService: ActivityService!
  
  func setupBinding() {
    $presentingSettings
      .filter { !$0 }
      .sink { [weak self] presentingSettings in
        if presentingSettings { return }
        self?.reloadData()
      }
      .store(in: &cancellableSet)
  }
  
  func reloadData() {
    state = .loading
    activityService.getExpectingActivitiesAmount()
      .sink { [weak self] in self?.expectingActivitiesAmount = $0 }
      .cancel()
    activityService.getSubscribingActivityTypes()
      .sink { [weak self] in
        self?.subscribingActivityTypes = $0.isEmpty ? ActivityType.allCases : $0
      }
      .cancel()
    state = .loaded
  }
}
