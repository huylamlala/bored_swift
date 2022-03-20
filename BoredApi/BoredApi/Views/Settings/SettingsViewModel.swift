//
//  SettingsViewModel.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Combine

class SettingsViewModel: ObservableObject {
  enum ViewStates: Equatable {
    case initial
    case loaded
  }
  @Published var expectingActivitiesAmount: ExpectingActivitiesAmount = .five
  @Published var subscribingActivityTypes = ActivityType.allCases
  @Published var state: ViewStates = .initial
  private var cancellableSet: Set<AnyCancellable> = []
  var activityService: ActivityService!
  
  func setupBinding() {
    activityService.getExpectingActivitiesAmount()
      .sink { [weak self] in self?.expectingActivitiesAmount = $0 }
      .store(in: &cancellableSet)
    activityService.getSubscribingActivityTypes()
      .sink { [weak self] in self?.subscribingActivityTypes = $0 }
      .store(in: &cancellableSet)
    state = .loaded
  }
  
  func onUnsubscribe(activityType: ActivityType) {
    activityService.unsubscribeActivityType(activityType)
  }
  
  func onSubscribe(activityType: ActivityType) {
    activityService.subscribeActivityType(activityType)
  }
  
  func onChangeExpectingActivitiesAmount(_ newValue: Int) {
    guard let expectingActivitiesAmount = ExpectingActivitiesAmount(rawValue: newValue) else {
      return
    }
    activityService.setExpectingActivitiesAmount(expectingActivitiesAmount)
  }
}
