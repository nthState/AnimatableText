//
//  Copyright nthState 2024
//

import SwiftUI

struct ContentView {}

extension ContentView: View {

  var body: some View {
    content
  }

  private var content: some View {
    AnimatableText("Hello, World!") {

      AnimatedTextAction("Hello", animation: nil) { value in

      }

      AnimatedTextAction("W", animation: nil) { value in

      }
    }
  }

}

#Preview {
  ContentView()
}
