//
//  Copyright nthState 2024
//

import SwiftUI

struct AnimatableText {
  
  private var mutableAttributedString: NSMutableAttributedString
  private let glyphs: [Glyph]
  private var items: [AnimatedTextAction] = []

  public init(_ attributedString: NSAttributedString, @AnimatedTextContentBuilder innerContent: @escaping (NSMutableAttributedString) -> [AnimatedTextAction]) {

    print("---Init---")

    self.mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

    let range = NSRange(location: 0, length: attributedString.length)
    // Disable ligatures, haven't found the correct method of getting them to work
    self.mutableAttributedString.addAttribute(kCTLigatureAttributeName as NSAttributedString.Key, value: 0, range: range)
    self.mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: range)
    self.mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)



    for item in innerContent(self.mutableAttributedString) {

      guard let matches = self.mutableAttributedString.matches(pattern: item.pattern) else {
        print("Skipping, no matches found")
        continue
      }

      item.action(matches)
    }

    let size = self.mutableAttributedString.suggestedSize(for: 320)
    self.glyphs = self.mutableAttributedString.glyphPositions(size: size, indexes: [])

    //print("mutableAttributedString: \(self.mutableAttributedString)")
    
    //_ = innerContent(self.mutableAttributedString)
  }

  public init(_ string: String, @AnimatedTextContentBuilder innerContent: @escaping (NSMutableAttributedString) -> [AnimatedTextAction]) {
    self.init(NSAttributedString(string: string), innerContent: innerContent)
  }
}

extension AnimatableText: View {

  var body: some View {
    ZStack {
      ForEach(glyphs, id: \.id) { glyph in
        GlyphView(glyph: glyph)
      }
    }
  }
}
