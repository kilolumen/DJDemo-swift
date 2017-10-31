//
//  Corner.swift
//  CutCorner
//
//  Created by Weico on 13/02/2017.
//  Copyright © 2017 kilolumen. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func clip(cornerRadius: CGFloat) -> UIImage? {
        let w = self.size.width * self.scale
        let h = self.size.height * self.scale
        let rect = CGRect(x: 0, y: 0, width: w, height: h)

        UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: h), false, 1.0)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func clip2(cornerRadius: CGFloat) -> UIImage? {
        let w = self.size.width * self.scale
        let h = self.size.height * self.scale

        UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: h), false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 0, y: cornerRadius))
        context?.addArc(tangent1End: CGPoint.init(x: 0, y: 0), tangent2End: CGPoint.init(x: cornerRadius, y: 0), radius: cornerRadius)
        context?.addLine(to: CGPoint.init(x: w - cornerRadius, y: 0))
        context?.addArc(tangent1End: CGPoint.init(x: w, y: 0), tangent2End: CGPoint.init(x: w, y: cornerRadius), radius: cornerRadius)
        context?.addLine(to: CGPoint.init(x: w, y: h - cornerRadius))
        context?.addArc(tangent1End: CGPoint.init(x: w, y: h), tangent2End: CGPoint.init(x: w - cornerRadius, y: h), radius: cornerRadius)
        context?.addLine(to: CGPoint.init(x: cornerRadius, y: h))
        context?.addArc(tangent1End: CGPoint.init(x: 0, y: h), tangent2End: CGPoint.init(x: 0, y: h - cornerRadius), radius: cornerRadius)
        context?.addLine(to: CGPoint.init(x: 0, y: cornerRadius))
        context?.closePath()

        context?.clip()
        draw(in: CGRect.init(x: 0, y: 0, width: w, height: h))
        context?.drawPath(using: .fill)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func clip3(radius: CGFloat, size: CGSize, borderWidth: CGFloat, color: UIColor) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: radius, height: radius)).cgPath)
        context?.clip()
        draw(in: rect)
        context?.drawPath(using: .fillStroke)
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(borderWidth)
        let path = UIBezierPath.init(roundedRect: rect.insetBy(dx: borderWidth*0.5, dy: borderWidth*0.5), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: radius, height: radius)).cgPath
        context?.addPath(path)
        context?.drawPath(using: .stroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
