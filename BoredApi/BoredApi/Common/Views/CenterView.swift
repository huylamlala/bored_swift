//
//  Center.swift
//  BoredApi
//
//  Created by Huy Lam on 19/03/2022.
//

import SwiftUI

struct CenterView<Content>: View where Content : View {
  let content: () -> Content
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: content)
  }
}
