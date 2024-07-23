//
//  ActivityIndicator.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import Foundation
import SwiftUI

struct ActivityIndicator: View {
  @State private var currentIndex: Int = 0

  func incrementIndex() {
    currentIndex += 1
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
      self.incrementIndex()
    })
  }

  var body: some View {
    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<12) { index in
        Group {
          Rectangle()
            .cornerRadius(geometry.size.width / 5)
            .frame(width: geometry.size.width / 8, height: geometry.size.height / 3)
            .offset(y: geometry.size.width / 2.25)
            .rotationEffect(.degrees(Double(-360 * index / 12)))
            .opacity(self.setOpacity(for: index))
        }.frame(width: geometry.size.width, height: geometry.size.height)
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .onAppear {
      self.incrementIndex()
    }
  }

  func setOpacity(for index: Int) -> Double {
    let opacityOffset = Double((index + currentIndex - 1) % 11 ) / 12 * 0.9
    return 0.1 + opacityOffset
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ActivityIndicator()
      .frame(width: 40, height: 40)
      .foregroundColor(.gray)
  }
}

