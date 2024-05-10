//
//  Copyright nthState 2024
//

import SwiftUI

public struct AnimatedTextAction {

  public let pattern: String
  public var action: (NSMutableAttributedString, [NSTextCheckingResult]) -> ()

  init(pattern: String, action: @escaping (NSMutableAttributedString, [NSTextCheckingResult]) -> ()) {
    self.pattern = pattern
    self.action = action
  }

}

extension AnimatedTextAction: CustomDebugStringConvertible {
  public var debugDescription: String {
    "pattern: \(pattern)"
  }
}
