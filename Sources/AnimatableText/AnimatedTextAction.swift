//
//  Copyright nthState 2024
//

import SwiftUI

public struct AnimatedTextAction {

  public let string: String

  init(_ string: String, animation: Animation? = nil, complete: (String) -> ()) {
    self.string = string
  }

}

extension AnimatedTextAction: CustomDebugStringConvertible {
  public var debugDescription: String {
    "string: \(string)"
  }
}
