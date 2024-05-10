//
//  Copyright nthState 2024
//

import CoreText
import Foundation
import OSLog
import UIKit

extension NSMutableAttributedString {

  /**
   CoreText uses a bottom-left = zero, zero co-ordinate system
   */
  func glyphPositions(size: CGSize, indexes: [Int]) -> [Glyph] {

    var output: [Glyph] = []
    var characterCounter: Int = 0
    var characterCounterUTF16: Int = 0

    let attributedString = self

    let string = attributedString.string


    let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
    let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)

    //print("in glyph positions with string: \(string) \(bounds)")

    var lineOriginTransform = CGAffineTransform.identity
    lineOriginTransform = CGAffineTransformTranslate(lineOriginTransform, 0, bounds.height)
    lineOriginTransform = CGAffineTransformScale(lineOriginTransform, 1, -1)

    let frame = CTFramesetterCreateFrame(framesetter, CFRange(), CGPath(rect: bounds, transform: nil), nil)

    let lines = CTFrameGetLines(frame) as? [CTLine] ?? []

    let linesCount = lines.count

    let lineOrigins: [CGPoint] = [CGPoint](unsafeUninitializedCapacity: linesCount) { (bufferPointer, count) in
      if let baseAddress = bufferPointer.baseAddress {
        CTFrameGetLineOrigins(frame, CFRange(), baseAddress)
        count = linesCount
      }
    }

    //print("linesCount: \(linesCount)")

    for i in 0..<lineOrigins.count {
      let line = lines[i]
      guard let runs = CTLineGetGlyphRuns(line) as? [CTRun] else {
        continue
      }

      let flippedOrigin = CGPointApplyAffineTransform(lineOrigins[i], lineOriginTransform)

      for run in runs {

        let runGlyphsCount = CTRunGetGlyphCount(run)
        let glyphPositions = [CGPoint](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
          if let baseAddress = bufferPointer.baseAddress {
            CTRunGetPositions(run, CFRange(), baseAddress)
            count = runGlyphsCount
          }
        }

        let glyphs = [CGGlyph](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in

          if let baseAddress = bufferPointer.baseAddress {
            CTRunGetGlyphs(run, CFRange(), baseAddress)
            count = runGlyphsCount
          }
        }

        guard var attributes: [String: Any] = (CTRunGetAttributes(run) as NSDictionary as? [String: Any]) else { return output }
        attributes = attributes
          .reduce([:]) { (partialResult: [String: Any], tuple: (key: String, value: Any)) in
            var result = partialResult
            result[tuple.key] = tuple.value
            return result
          }

        var presentation: InlinePresentationIntent?
        if let value = attributes["NSInlinePresentationIntent"] as? UInt {
          presentation = InlinePresentationIntent(rawValue: value)
        }

        var color: UIColor = UIColor.black
        if let value = attributes["NSColor"] as? UIColor {
          color = value
        }

        // swiftlint:disable force_cast
        let font = attributes["NSFont"] as! CTFont
        // swiftlint:enable force_cast

        var link: String?
        if let linkValue = attributes["NSLink"] as? String {
          link = linkValue
        } else if let attachmentValue = attributes["NSAttachment"] as? String {
          link = attachmentValue
        }

        let glyphOpticalRects = glyphs.opticalBounds(for: font)

        for k in 0..<glyphPositions.count {
          let point = glyphPositions[k]
          let optical = glyphOpticalRects[k]

          var box = optical
          box.origin.x = point.x
          box.origin.x += optical.midX

          box.origin.y = flippedOrigin.y
          box.origin.y -= (optical.midY)

          let textbox = box

          let charIndex = string.index(string.startIndex, offsetBy: characterCounter)
          let char = string[charIndex]

          let glyph = Glyph(id: characterCounter,
                            box: box,
                            textbox: textbox,
                            glyph: String(char),
                            font: font,
                            presentation: presentation,
                            color: color,
                            appearanceDelay: 0,
                            link: link,
                            offset: CGSize(width: 0, height: 0))

          output.append(glyph)

          //print("Add glyph")

          characterCounter += 1
          characterCounterUTF16 += char.utf16.count
        }
      }
    }

    return output
  }

}
