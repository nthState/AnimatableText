//
//  Copyright nthState 2024
//

import SwiftUI

@resultBuilder
public struct AnimatedTextContentBuilder {

  public static func buildBlock(_ components: AnimatedTextAction...) -> [AnimatedTextAction] {
    return components
  }

}
