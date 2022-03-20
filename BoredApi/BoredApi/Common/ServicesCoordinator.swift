//
//  ServicesCoordinator.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Foundation

enum ServicesCoordinator {
  static func buildActivityService(in env: Environment) -> ActivityService {
    switch env {
    case .preview:
      return ActivityServiceMock()
    case .dev:
      return ActivityNetworkingServices()
    }
  }
}
