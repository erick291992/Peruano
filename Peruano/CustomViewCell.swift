//
//  CustomViewCell.swift
//  Peruano
//
//  Created by Erick Manrique on 7/3/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

@IBDesignable class CustomViewCell: UIView {

//    @IBInspectable var topCorners:CGFloat = 0{
//        didSet{
////            roundCorners([.TopRight, .TopLeft], radius: topCorners)
//            roundCorners(.AllCorners, radius: topCorners)
//        }
//    }

//        @IBInspectable var customB:UIColor = UIColor.blackColor(){
//            didSet{
//                self.backgroundColor = customB
//            }
//        }

//    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.CGPath
//        self.layer.mask = mask
//    }
    
    override func awakeFromNib() {
//        layer.cornerRadius = 13.0
        
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
}
