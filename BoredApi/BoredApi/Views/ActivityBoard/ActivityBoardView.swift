//
//  ActivityBoardView.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import SwiftUI

struct ActivityBoardView: View {
  @EnvironmentObject var envSettings: EnvironmentSettings
  @ObservedObject var viewModel: ActivityBoardViewModel = ActivityBoardViewModel()
  
  var body: some View {
    Group {
      switch viewModel.state {
      case .initial:
        initialView
      case .loading:
        progressView
      case .loaded:
        tabsView
      }
    }
  }
  
  var initialView: some View {
    viewModel.activityService = ServicesCoordinator.buildActivityService(in: envSettings.env)
    viewModel.setupBinding()
    return EmptyView()
  }
  
  var progressView: some View {
    CenterView {
      ProgressView()
    }
  }
  
  var tabsView: some View {
    TabView {
      ForEach(viewModel.subscribingActivityTypes, id: \.self) { type in
        ActivitiesListView(activityType: type, numberOfResult: viewModel.expectingActivitiesAmount)
      }
    }
    .tabViewStyle(PageTabViewStyle())
    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

struct ActivityBoardView_Previews: PreviewProvider {
  static var previews: some View {
    let envSettings = EnvironmentSettings()
    envSettings.env = .preview
    let viewModel = ActivityBoardViewModel()
    viewModel.state = .loaded
    var view = ActivityBoardView()
    view.viewModel = viewModel
    return view
      .environmentObject(envSettings)
      .colorScheme(.dark)
  }
}

