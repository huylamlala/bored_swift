//
//  UserDefaults+Extensions.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Foundation

extension UserDefaults {
  @objc dynamic var expectingActivitiesAmount: Int {
    return integer(forKey: Constants.UserDefaultsKeys.expectingActivitiesAmount.rawValue)
  }
  
  @objc dynamic var subscribingActivityTypes: [String] {
    return stringArray(forKey: Constants.UserDefaultsKeys.subscribingActivityTypes.rawValue) ?? []
  }
}
