//
//  ViewExtension.swift
//  Task-22-Aug
//
//  Created by Mac on 24/08/23.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        
        get {
            return layer.cornerRadius
        }
    }
   
    
    
}



