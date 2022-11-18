//
//  CardView.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 17/08/22.
//

import Foundation

import UIKit

//This class is used to create reusable view which can modified from storyboard.
@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadiusValue: CGFloat = 20  //Corner radius of view
    @IBInspectable var shadowOffsetWidth: Int = 0 //width of shadow around view
    @IBInspectable var shadowOffsetHeight: Int = 3 //shadow height
    @IBInspectable var shadowColor: UIColor? = UIColor.gray //color of shadow around view
    @IBInspectable var shadowOpacity: Float = 0.3  //opacity of shadow which decide how dark shadow should looks.

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiusValue
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
