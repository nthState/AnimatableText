//
//  Copyright nthState 2024
//

import SwiftUI

struct GlyphView: View {
  
  @State var opacity: Double = 0
  let glyph: Glyph
  
  var body: some View {
    Text(glyph.glyph)
      .font(font)
      .opacity(opacity)
      .fixedSize()
      .frame(width: glyph.box.width, height: glyph.box.height)
      .foregroundColor(Color(uiColor: glyph.color))
      .position(glyph.box.origin)
      .offset(glyph.offset)
      .onAppear {
        withAnimation(
          .linear(duration: 1)
          .delay(Double(glyph.id) * 0.05)
        ) {
          opacity = 1
        }
      }
  }
  
  var font: Font {
    guard let presentation = glyph.presentation else {
      return Font(glyph.font)
    }
    
    switch presentation {
    case .emphasized:
      return Font(glyph.font).italic()
    case .stronglyEmphasized:
      return Font(glyph.font).bold()
    default:
      return Font(glyph.font)
    }
    
  }
  
}
