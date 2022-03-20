//
//  AppTypography.swift
//  BoredApi
//
//  Created by Huy Lam on 20/03/2022.
//

import SwiftUI

enum AppTypography {
  case title
  case heading
  case subHeading
  case body
  case button
  
  var fontSize: CGFloat {
    switch self {
    case .title:
      return 24
    case .heading:
      return 20
    case .subHeading:
      return 18
    case .body:
      return 15
    case .button:
      return 14
    }
  }
  
  var fontWeight: Font.Weight {
    switch self {
    case .title:
      return .bold
    case .heading:
      return .medium
    case .subHeading:
      return .semibold
    case .body:
      return .light
    case .button:
      return .bold
    }
  }
}

struct ScaledFont: ViewModifier {
  var appTypography: AppTypography
  
  func body(content: Content) -> some View {
    let scaledSize = UIFontMetrics.default.scaledValue(for: appTypography.fontSize)
    return content.font(.system(size: scaledSize, weight: appTypography.fontWeight))
  }
}

extension View {
  func scaledFont(appTypography: AppTypography) -> some View {
    return self.modifier(ScaledFont(appTypography: appTypography))
  }
}
