//
//  CornerModifier.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUICore

struct CornerModifier: ViewModifier {
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        
        if bottomOffset < 38 {
            content
        } else {
            content.cornerRadius(12)
        }
    }
}
