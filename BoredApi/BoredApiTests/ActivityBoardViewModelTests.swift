//
//  ActivityBoardViewModelTests.swift
//  BoredApiTests
//
//  Created by Huy Lam on 20/03/2022.
//

import XCTest
@testable import BoredApi
import Mockingbird
import Combine

class ActivityBoardViewModelTests: XCTestCase {
  var viewModel: ActivityBoardViewModel!
  var activityServiceMock: ActivityServiceMock!
  
  override func setUpWithError() throws {
    viewModel = ActivityBoardViewModel()
    activityServiceMock = mock(ActivityService.self)
    viewModel.activityService = activityServiceMock
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
    viewModel.presentingSettings = false
    // when presenting settings is false
    // should call reload data and update
    verify(activityServiceMock.getExpectingActivitiesAmount()).wasCalled()
    verify(activityServiceMock.getSubscribingActivityTypes()).wasCalled()
    XCTAssert(subscribingActivityTypes == viewModel.subscribingActivityTypes)
    XCTAssert(expectingActivitiesAmount == viewModel.expectingActivitiesAmount)
  }
}
