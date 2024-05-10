//
//  Copyright nthState 2024
//

import SwiftUI

public struct AnimatedTextAction {

  public let pattern: String
  public var action: ([NSTextCheckingResult]) -> ()

  init(pattern: String, action: @escaping ([NSTextCheckingResult]) -> ()) {
    self.pattern = pattern
    self.action = action
  }

}

extension AnimatedTextAction: CustomDebugStringConvertible {
  public var debugDescription: String {
    "pattern: \(pattern)"
  }
}
