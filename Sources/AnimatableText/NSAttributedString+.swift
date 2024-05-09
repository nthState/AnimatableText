//
//  Copyright nthState 2024
//

import CoreText
import Foundation
import UIKit

extension NSAttributedString {

    func suggestedSize(for width: CGFloat) -> CGSize {
            let bounds = CGRect(x: 0, y: 0, width: width, height: 10_000)
            let framesetter = CTFramesetterCreateWithAttributedString(self)
            let suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,
                                                                             CFRange(),
                                                                             nil,
                                                                             bounds.size,
                                                                             nil)
            return suggestedSize
        }

}
