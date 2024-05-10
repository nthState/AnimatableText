//
//  Copyright nthState 2024
//

import SwiftUI

struct ContentView {

  let displayString = "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea? Is there fiction in science or sci-fi?"

  @State var on: Bool = true
  @State var isFloating: Bool = false

  private func toggle() {
    withAnimation {
      on.toggle()
    }
  }

  private func toggleFloat() {
    withAnimation {
      isFloating.toggle()
    }
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
    AnimatableText(displayString) { mutableAttributedString in

      AnimatedTextAction(pattern: #"float"#) {  matches in
        // If the text is float, I'd like the text to float up the screen

        // Question: How could one make the Glyphs accessible via animation in a detacted state?
        // So that if they grew, they would not affect the rest of the text?

        if isFloating {
          matches.forEach { result in

            var yPos: CGFloat = 100
            for part in result.range.location...result.range.location+result.range.length {
              let r = NSRange(location: part, length: 1)
              mutableAttributedString.addAttribute(.offset, value: CGSize(width: 0, height: yPos), range: r)
              yPos += 10
            }
            //mutableAttributedString.addAttribute(.offset, value: CGSize(width: 0, height: 100), range: result.range)
          }
        }
      }

      AnimatedTextAction(pattern: #"big"#) {  matches in
        // If the word is big, I'd like the text to grow in size

        if on {

          matches.forEach { result in
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
          }

        }

      }

      AnimatedTextAction(pattern: #"blue"#) {  matches in
        // If the word is blue, the text should turn blue

        if on {
          matches.forEach { result in
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: result.range)
            mutableAttributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 40), range: result.range)
          }
        }

      }

      AnimatedTextAction(pattern: #"dive"#) { matches in
        // If I press on the word `dive` then what could happen?

        // Question: Is there a way I can use Animations?

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
    Button(action: toggleFloat, label: {
      Text("Float")
    })
  }

}

#Preview {
  ContentView()
}
