//
//  Copyright nthState 2024
//

import SwiftUI

struct GlyphView: View {

    let glyph: Glyph

    var body: some View {
        Text(glyph.glyph)
            .font(font)
            .fixedSize()
            .frame(width: glyph.box.width, height: glyph.box.height)
            .position(glyph.box.origin)
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