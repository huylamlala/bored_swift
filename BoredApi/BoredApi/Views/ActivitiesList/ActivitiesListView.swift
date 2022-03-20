//
//  ActivitiesListView.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import SwiftUI

struct ActivitiesListView: View {
  init(activityType: ActivityType, numberOfResult: ExpectingActivitiesAmount) {
    self.activityType = activityType
    self.numberOfResult = numberOfResult
  }
  let activityType: ActivityType
  let numberOfResult: ExpectingActivitiesAmount
  @EnvironmentObject var envSettings: EnvironmentSettings
  @ObservedObject var viewModel = ActivitiesListViewModel()
  @State var selection: Int? = nil
  
  var body: some View {
    ScrollView{
      VStack {
        HStack {
          Text(activityType.rawValue.uppercased())
            .scaledFont(appTypography: .heading)
            .padding(.top)
            .padding(.leading, 8)
          Spacer()
        }
        Group {
          switch viewModel.state {
          case .initial:
            initialView
          case .error(let error):
            buildErrorView(error: error)
          case .activitiesLoaded(let activities):
            buildActivityViews(activities)
          case .loading:
            progressView
          }
        }
        Spacer()
      }
      
    }
  }
  
  var progressView: some View {
    CenterView {
      ProgressView()
    }
  }
  
  var initialView: some View {
    viewModel.activityService = ServicesCoordinator.buildActivityService(in: envSettings.env)
    viewModel.getActivities(type: activityType, numberOfResult: numberOfResult.rawValue)
    return progressView
  }
  
  func buildErrorView(error: APIError) -> some View {
    CenterView {
      Text(error.localizedDescription)
        .scaledFont(appTypography: .body)
        .foregroundColor(.red)
    }
  }
  
  func buildActivityViews(_ activities: [Activity]) -> some View {
    VStack {
      ForEach(activities, id: \.activity) { activity in
        buildActivityCard(activity)
          .padding(.horizontal)
          .padding(.bottom)
      }
      Spacer()
    }
  }
  
  func buildActivityCard(_ activity: Activity) -> some View  {
    NavigationLink(destination: ActivityDetailView(activity: activity)) {
      VStack(alignment: .leading) {
        Text(activity.activity)
          .lineLimit(2)
          .fixedSize(horizontal: false, vertical: true)
          .multilineTextAlignment(.leading)
          .scaledFont(appTypography: .subHeading)
        Spacer()
        HStack {
          Label("\(activity.participants)", systemImage: "person.3.fill")
          Spacer()
          Label(String(format: "%.2f", activity.accessibility), systemImage: "heart.fill")
            .padding(.trailing, 20)
        }
        .scaledFont(appTypography: .body)
      }
      .foregroundColor(Color(UIColor.label))
      .padding()
      .background(Color(UIColor.systemGroupedBackground))
      .cornerRadius(25)
    }
  }
}
