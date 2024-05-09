//
//  Copyright nthState 2024
//

import Foundation
import CoreText

extension Array where Element == CGGlyph {

    func opticalBounds(for font: CTFont) -> [CGRect] {
      [CGRect](unsafeUninitializedCapacity: count) { (bufferPointer, count) in
          if let baseAddress = bufferPointer.baseAddress {
              CTFontGetOpticalBoundsForGlyphs(font, self, baseAddress, self.count, CFOptionFlags())
              count = self.count
          }
      }
    }

}
