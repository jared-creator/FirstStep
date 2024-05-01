//
//  TextSize+Ext.swift
//  FirstStep
//
//  Created by JaredMurray on 4/30/24.
//

import Foundation
import SwiftUI

extension ContentSizeCategory {
    
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        default :
            return 0.6
        }
    }
}

extension DynamicTypeSize {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .xSmall, .small, .medium:
            return 1.0
        case .large, .xLarge:
            return 0.8
        default:
            return 0.4
        }
    }
}
