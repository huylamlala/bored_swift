//
//  ActivityDetailView.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import SwiftUI

struct ActivityDetailView: View {
  private let activity: Activity

  init(activity: Activity) {
    self.activity = activity
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack { Spacer() }
      Group{
        Label("\(activity.participants)", systemImage: "person.3.fill")
        Label(String(format: "%.2f", activity.accessibility), systemImage: "heart.fill")
        Label(String(format: "%.2f", activity.price), systemImage: "dollarsign.circle.fill")
        Label(activity.type.rawValue, systemImage: "book.fill")
        
        Spacer()
      }
      .padding(.horizontal, 10)
    }
    .navigationTitle(Text(activity.activity))
  }
}
