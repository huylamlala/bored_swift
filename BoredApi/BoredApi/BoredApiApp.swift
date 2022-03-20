//
//  BoredApiApp.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import SwiftUI

@main
struct BoredApiApp: App {
  @StateObject private var envSettings = EnvironmentSettings()

 
  var body: some Scene {
    WindowGroup {
      ActivityBoardView()
        .environmentObject(envSettings)
    }
  }
}
