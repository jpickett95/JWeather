//
//  CornerModifier.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUICore

// MARK: Corner Modifier ViewModifier

/**
 A ViewModifier that creates a cornerRadius for a View, depending on the given bottomOffset.
 */
struct CornerModifier: ViewModifier {
    // MARK: Properties
    @Binding var bottomOffset: CGFloat
    
    
    // MARK: Body
    func body(content: Content) -> some View {
        if bottomOffset < 38 {
            content
        } else {
            content.cornerRadius(12)
        }
    }
}
