//
//  SettingsViewModelTests.swift
//  BoredApiTests
//
//  Created by Huy Lam on 20/03/2022.
//

import XCTest
@testable import BoredApi
import Mockingbird
import Combine

class SettingsViewModelTests: XCTestCase {
  var viewModel: SettingsViewModel!
  var activityServiceMock: ActivityServiceMock!
  
  override func setUpWithError() throws {
    viewModel = SettingsViewModel()
    activityServiceMock = mock(ActivityService.self)
    viewModel.activityService = activityServiceMock
  }
  
  func testChangeExpectingActivitiesAmountFailed() throws {
    // when new value is not in range [1...10]
    // should not change
    viewModel.onChangeExpectingActivitiesAmount(11)
    verify(activityServiceMock.setExpectingActivitiesAmount(any())).wasNeverCalled()
  }
  
  func testChangeExpectingActivitiesAmountSuccessfully() throws {
    // when new value is in range [1...10]
    // should change
    viewModel.onChangeExpectingActivitiesAmount(10)
    verify(activityServiceMock.setExpectingActivitiesAmount(any())).wasCalled()
  }
  
  func testUnsubscribeActivityType() throws {
    let activityType = ActivityType.allCases.randomElement()!
    // when unsubscribe activity type
    // service should unsubscribe that activity type
    viewModel.onUnsubscribe(activityType: activityType)
    verify(activityServiceMock.unsubscribeActivityType(activityType)).wasCalled()
  }
  
  func testSubscribeActivityType() throws {
    let activityType = ActivityType.allCases.randomElement()!
    // when subscribe activity type
    // service should subscribe that activity type
    viewModel.onSubscribe(activityType: activityType)
    verify(activityServiceMock.subscribeActivityType(activityType)).wasCalled()
  }
  
  func testSetupBinding() throws {
    // given
    let expectingActivitiesAmount = ExpectingActivitiesAmount.allCases.randomElement()!
    let subscribingActivityTypes: [ActivityType] = [.education, .busywork, .charity]
    given(activityServiceMock.getExpectingActivitiesAmount()) ~> {
      return Just(expectingActivitiesAmount).eraseToAnyPublisher()
    }
    given(activityServiceMock.getSubscribingActivityTypes()) ~> {
      return Just(subscribingActivityTypes).eraseToAnyPublisher()
    }
    viewModel.setupBinding()
    // when presenting settings is false
    // should call reload data and update
    verify(activityServiceMock.getExpectingActivitiesAmount()).wasCalled()
    verify(activityServiceMock.getSubscribingActivityTypes()).wasCalled()
    XCTAssert(subscribingActivityTypes == viewModel.subscribingActivityTypes)
    XCTAssert(expectingActivitiesAmount == viewModel.expectingActivitiesAmount)
  }
  
}
