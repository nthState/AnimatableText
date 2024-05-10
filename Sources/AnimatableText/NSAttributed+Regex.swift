//
//  Copyright nthState 2024
//

import Foundation

extension NSAttributedString {

  func matches(pattern: String) -> [NSTextCheckingResult]? {
    let range = NSRange(location: 0, length: self.string.count)
    let regex: NSRegularExpression
    do {
      regex = try NSRegularExpression(pattern: pattern)
    } catch let error {
      print("Regex error \(error.localizedDescription)")
      return nil
    }

    return regex.matches(in: self.string, range: range)
  }

}
