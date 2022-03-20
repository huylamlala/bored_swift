//
//  UserDefaults+Extensions.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import Foundation


extension UserDefaults {
  @objc dynamic var expectingActivitiesAmount: Int {
    return integer(forKey: "expectingActivitiesAmount")
  }
  
  @objc dynamic var subscribingActivityTypes: [String] {
    return stringArray(forKey: "subscribingActivityTypes") ?? []
  }
}
