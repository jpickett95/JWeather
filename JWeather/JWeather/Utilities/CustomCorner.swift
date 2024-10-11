//
//  CustomCorner.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUI

// MARK: Custom Corner Shape

/**
 A custom Shape object with a given corner radius.
 */
struct CustomCorner: Shape {
    // MARK: Properties
    var corners: UIRectCorner
    var radius: CGFloat
    
    // MARK: Methods
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


