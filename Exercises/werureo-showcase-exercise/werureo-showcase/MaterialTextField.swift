//
//  MaterialTextField.swift
//  werureo-showcase
//
//  Created by Keli'i Martin on 3/13/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialTextField: UITextField
{
    override func awakeFromNib()
    {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
    }

    ////////////////////////////////////////////////////////////

    override func textRectForBounds(bounds: CGRect) -> CGRect
    {
        return CGRectInset(bounds, 10, 0)
    }

    ////////////////////////////////////////////////////////////

    override func editingRectForBounds(bounds: CGRect) -> CGRect
    {
        return CGRectInset(bounds, 10, 0)
    }
}
