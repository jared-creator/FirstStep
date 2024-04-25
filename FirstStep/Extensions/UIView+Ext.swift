//
//  UIView+Ext.swift
//  FirstStep
//
//  Created by JaredMurray on 4/18/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
