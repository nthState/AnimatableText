//
//  Copyright nthState 2024
//

import CoreText
import Foundation
import UIKit

struct Glyph: Identifiable {
    let id: Int
    let box: CGRect
    let textbox: CGRect
    let glyph: String
    let font: CTFont
    let presentation: InlinePresentationIntent?
    let color: UIColor
    let appearanceDelay: Double
    let link: String?
    let offset: CGSize
}
