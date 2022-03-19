//
//  ActivitiesListView.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import SwiftUI

struct ActivitiesListView: View {
  init(activityType: ActivityType) {
    self.activityType = activityType
  }
  let activityType: ActivityType
  @ObservedObject var viewModel = ActivitiesListViewModel()
  
  var body: some View {
    Group {
      switch viewModel.state {
      case .initial:
        initialView
      case .error(let error):
        buildErrorView(error: error)
      case .activitiesLoaded(let activities):
        buildActivityViews(activities)
      case .loading:
        CenterView {
          ProgressView()
        }
      }
      
    }
  }
  
  var initialView: some View {
    viewModel.activityService = ActivityNetworkingServices()
    viewModel.getActivities(type: activityType, numberOfResult: 5)
    return CenterView {
      ProgressView()
    }
  }
  
  func buildErrorView(error: APIError) -> some View {
    CenterView {
      Text(error.localizedDescription)
    }
  }
  
  func buildActivityViews(_ activities: [Activity]) -> some View {
    VStack {
      ForEach(activities, id: \.activity) { activity in
        Text(activity.activity)
          .padding()
      }
    }
  }
}
