//
//  Extension.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation
import UIKit

extension UIView {
    var width : CGFloat {
        return frame.size.width
    }
    var height : CGFloat {
        return frame.size.height
    }
    var left : CGFloat {
        return frame.origin.x
    }
    var right : CGFloat {
        return width + left
    }
    var top : CGFloat {
        return frame.origin.y
    }
    var bottom : CGFloat {
        return top + height
    }
}
