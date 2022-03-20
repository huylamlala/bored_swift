//
//  EnvironmentSettings.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Combine
class EnvironmentSettings: ObservableObject {
  @Published var env: Environment = .dev
}

enum Environment {
  case preview, dev
}
