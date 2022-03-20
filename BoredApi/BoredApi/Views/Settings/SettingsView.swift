//
//  SettingsView.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var envSettings: EnvironmentSettings
  @ObservedObject var viewModel = SettingsViewModel()
  @Binding var presentedAsModal: Bool
  
  var body: some View {
    Group {
      switch viewModel.state {
      case .initial:
        initialView
      case .loaded:
        settingsView
      }
    }
    .navigationTitle(Text("Settings"))
  }
    
  var initialView: some View {
    viewModel.activityService = ServicesCoordinator.buildActivityService(in: envSettings.env)
    viewModel.setupBinding()
    return EmptyView()
  }
  
  var settingsView: some View {
    ScrollView {
      VStack(alignment: .leading) {
        numberResultsSettings
          .padding(.bottom)
        Text("Activity Types")
          .scaledFont(appTypography: .heading)
        ForEach(ActivityType.allCases, id: \.self) {
          buildActivityTypeItem($0, isSubscribing: viewModel.subscribingActivityTypes.contains($0))
        }
        Spacer()
      }
      .padding()
    }
    .onDisappear(perform: {
      presentedAsModal = false
    })
  }
  
  func buildActivityTypeItem(_ activityType: ActivityType, isSubscribing: Bool) -> some View {
    HStack {
      Text(activityType.rawValue.uppercased())
        .scaledFont(appTypography: .subHeading)
      Spacer()
      Button(action: {
        isSubscribing
          ? viewModel.onUnsubscribe(activityType: activityType)
          : viewModel.onSubscribe(activityType: activityType)
      }, label: {
        Text(
          isSubscribing
            ? "Unsubscribe".uppercased()
            : "Subscribe".uppercased()
        )
        .scaledFont(appTypography: .button)
        .foregroundColor(.white)
        .padding()
        .background(isSubscribing ? Color.red : Color.green)
        .cornerRadius(8)
      })
    }
    .padding()
  }
  
  var numberResultsSettings: some View {
    HStack(alignment: .center) {
      Text("Number of results")
        .scaledFont(appTypography: .heading)
      Spacer()
      Group {
        Button(action: {
          let newValue = viewModel.expectingActivitiesAmount.rawValue - 1
          viewModel.onChangeExpectingActivitiesAmount(newValue)
        }, label: {
          Image(systemName: "minus")
        })
        Text("\(viewModel.expectingActivitiesAmount.rawValue)")
          .padding(.horizontal)
        Button(action: {
          let newValue = viewModel.expectingActivitiesAmount.rawValue + 1
          viewModel.onChangeExpectingActivitiesAmount(newValue)
        }, label: {
          Image(systemName: "plus")
        })
      }
    }
  }
}
