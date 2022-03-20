//
//  ActivitiesListViewModelTests.swift
//  BoredApiTests
//
//  Created by Huy Lam on 20/03/2022.
//

import XCTest
@testable import BoredApi
import Mockingbird
import Combine

class ActivitiesListViewModelTests: XCTestCase {
  var viewModel: ActivitiesListViewModel!
  var activityServiceMock: ActivityServiceMock!
  
  override func setUpWithError() throws {
    viewModel = ActivitiesListViewModel()
    activityServiceMock = mock(ActivityService.self)
    viewModel.activityService = activityServiceMock
  }
  
  func testGetActivitiesSuccessfully() throws {
    // given
    let numberOfResults = [2, 3, 4, 5].randomElement()!
    let type: ActivityType = .allCases.randomElement()!
    givenSwift(activityServiceMock.getActivity(with: .getActivity(type: type))).will { _ in
      return Just(.success(Activity.draftModel)).eraseToAnyPublisher()
    }
    var activitiesLoaded: [Activity] = []
    for _ in 1...numberOfResults {
      activitiesLoaded.append(Activity.draftModel)
    }
    viewModel.getActivities(type: type, numberOfResult: numberOfResults)
    
    // when get activity successfully
    // state should be activitiesLoaded
    verify(activityServiceMock.getActivity(with: .getActivity(type: type))).wasCalled(numberOfResults)
    XCTAssert(viewModel.state == .activitiesLoaded(activitiesLoaded))
  }
  
  func testGetActivitiesFailed() throws {
    // given
    let numberOfResults = 1
    let type: ActivityType = .allCases.randomElement()!
    let error = APIError.custom(message: "some failed")
    givenSwift(activityServiceMock.getActivity(with: .getActivity(type: type))).will { _ in
      return Just(.failure(error)).eraseToAnyPublisher()
    }
    viewModel.getActivities(type: type, numberOfResult: numberOfResults)
    
    // when get activity failed
    // state should be error
    verify(activityServiceMock.getActivity(with: .getActivity(type: type))).wasCalled(numberOfResults)
    XCTAssert(viewModel.state == .error(error))
  }
  
}
