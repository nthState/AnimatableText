//
//  Copyright nthState 2024
//

import SwiftUI

struct ContentView {

  let displayString = "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea? "

  @State var on: Bool = true

  private func toggle() {
    withAnimation {
      on.toggle()
    }
  }

  private func float() {

  }

}

extension ContentView: View {

  var body: some View {
    content
  }

  private var content: some View {
    VStack {
      animatedTextView
      buttons
    }
  }

  private var buttons: some View {
    HStack {
      toggleButton
      floatButton
    }
  }

  private var animatedTextView: some View {
    AnimatableText(displayString) { string in

      AnimatedTextAction(pattern: #"float"#) { mutableAttributedString, matches in
        // If the text is float, I'd like the text to float up the screen
        // Question: How do I attach data to the glyph?

      }

      AnimatedTextAction(pattern: #"big"#) { mutableAttributedString, matches in
        // If the word is big, I'd like the text to grow in size

        if on {

          matches.forEach { result in
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
          }

        }

      }

      AnimatedTextAction(pattern: #"blue"#) { mutableAttributedString, matches in
        // If the word is blue, the text should turn blue

        if on {
          matches.forEach { result in
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: result.range)
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
          }
        }

      }

      AnimatedTextAction(pattern: #"dive"#) { mutableAttributedString, matches in
        // If I press on the word `dive` then what could happen?

        if on {
          matches.forEach { result in
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
          }
        } else {
          matches.forEach { result in
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 4), range: result.range)
          }
        }

      }

      let _ = print("End of actions")
    }
  }

  private var toggleButton: some View {
    Button(action: toggle, label: {
      Text("Toggle")
    })
  }

  private var floatButton: some View {
    Button(action: float, label: {
      Text("Float")
    })
  }

}

#Preview {
  ContentView()
}
