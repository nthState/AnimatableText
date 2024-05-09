//
//  Copyright nthState 2024
//

import SwiftUI

struct AnimatableText {
  
  private let mutableAttributedString: NSMutableAttributedString
  private let glyphs: [Glyph]
  private var items: [AnimatedTextAction] = []
  //private var callback: (() -> (NSAttributedString))?

  public init(_ attributedString: NSAttributedString, @AnimatedTextContentBuilder innerContent: @escaping (NSAttributedString) -> [AnimatedTextAction]) {

    print("---Init---")

    self.mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

    let range = NSRange(location: 0, length: attributedString.length)
    self.mutableAttributedString.addAttribute(kCTLigatureAttributeName as NSAttributedString.Key, value: 0, range: range)

    let size = self.mutableAttributedString.suggestedSize(for: 320)
    self.glyphs = self.mutableAttributedString.glyphPositions(size: size, indexes: [])

    for item in innerContent(self.mutableAttributedString) {
      print(item.debugDescription)
    }
    
    print("Finalizer")
    _ = innerContent(self.mutableAttributedString)
  }

  public init(_ string: String, @AnimatedTextContentBuilder innerContent: @escaping (NSAttributedString) -> [AnimatedTextAction]) {
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
