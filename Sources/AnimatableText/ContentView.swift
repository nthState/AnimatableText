//
//  Copyright nthState 2024
//

import SwiftUI

struct ContentView {

  let displayString = "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea?"

  let customA: NSMutableAttributedString = {

    let attributed = NSMutableAttributedString(string: "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea?")

    let range = NSRange(location: 0, length: attributed.length)
    attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: range)
    attributed.addAttribute(.foregroundColor, value: UIColor.red, range: range)

    Self.matches(pattern: #"blue"#, in: attributed)?.forEach({ result in
      let range = Range(result.range, in: attributed.string)
      attributed.addAttribute(.foregroundColor, value: UIColor.blue, range: result.range)
      attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
    })

    Self.matches(pattern: #"big"#, in: attributed)?.forEach({ result in
      let range = Range(result.range, in: attributed.string)
      attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
    })

    return attributed
  }()

  let customB: NSMutableAttributedString = {

    let attributed = NSMutableAttributedString(string: "Hello, World! Here's some big news for you, do you want to float away? or dive in the blue sea?")

    let range = NSRange(location: 0, length: attributed.length)
    attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: range)
    attributed.addAttribute(.foregroundColor, value: UIColor.red, range: range)

    let style = NSMutableParagraphStyle()
    style.paragraphSpacing = 20
    //style.headIndent = 20
    attributed.addAttribute(.paragraphStyle, value: style, range: range)

    Self.matches(pattern: #"dive"#, in: attributed)?.forEach({ result in
      let range = Range(result.range, in: attributed.string)
      attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: result.range)
    })

    return attributed
  }()

  static func matches(pattern: String, in attributed: NSAttributedString) -> [NSTextCheckingResult]? {
    let range = NSRange(location: 0, length: attributed.string.count)
    let regex: NSRegularExpression
    do {
        regex = try NSRegularExpression(pattern: pattern)
    } catch let error {
        print("Regex error \(error.localizedDescription)")
        return nil
    }

    return regex.matches(in: attributed.string, range: range)
  }

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
    AnimatableText(on ? customA : customB) { string in

      AnimatedTextAction("float", animation: nil) { value in
        // If the text is float, I'd like the text to float up the screen
        // Question: How do I attach data to the glyph?
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
