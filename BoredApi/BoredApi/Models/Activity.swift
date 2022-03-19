//
//  Activity.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import Foundation

struct Activity: Decodable {
  let activity: String
  let accessibility: Double
  let type: ActivityType
  let participants: Int
  let price: Double
  
  static var draftModel: Self {
    return Activity(activity: "Learn a new programming language",
                    accessibility: 0.25,
                    type: .education,
                    participants: 1,
                    price: 0.1)
  }
}

enum ActivityType: String, Decodable {
  case education, recreational, social, diy, charity, cooking, relaxation, music, busywork
}
