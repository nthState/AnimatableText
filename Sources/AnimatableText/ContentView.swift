//
//  Copyright nthState 2024
//

import SwiftUI

struct ContentView {
  let displayString = "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea?"
}

extension ContentView: View {

  var body: some View {
    content
  }

  private var content: some View {
    AnimatableText(displayString) { string in

      AnimatedTextAction("float", animation: nil) { value in
        // If the text is float, I'd like the text to float up the screen
      }

      AnimatedTextAction("big", animation: nil) { value in
        // If the word is big, I'd like the text to grow in size
      }

      AnimatedTextAction("blue", animation: nil) { value in
        // If the word is blue, the text should turn blue
      }

      AnimatedTextAction("dive", animation: nil) { value in
        // If I press on the word `dive` then what could happen?
      }

      let _ = print("End of actions")
    }
  }

}

#Preview {
  ContentView()
}
