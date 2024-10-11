//
//  CustomStackView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUI

// MARK: Custom Stack View

/**
 A custom Stack View that contains a titleview block & content block.
 */
struct CustomStackView<Title: View, Content: View>: View {
    // MARK: Properties
    var titleView: Title
    var contentView: Content
    
    // Offsets
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    
    // MARK: Lifecycle
    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
        
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    // MARK: Body
    var body: some View {
            
            VStack(spacing: 0) {
                
                // MARK: TitleView
                titleView
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.6))
                    .lineLimit(1)
                    .frame(height: 38)  // Max height
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .background(.blue.opacity(0.3))
                    .background(.ultraThinMaterial, in: CustomCorner(corners: bottomOffset < 38 ? .allCorners : [.topLeft, .topRight], radius: 12))
                    .zIndex(1)
                
                VStack {
                    
                    Divider()
                        .background(.white)
                    
                    // MARK: ContentView
                    contentView
                        .padding()
                    
                }
                .background(.blue.opacity(0.3))
                .background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
                // Moving content upwards
                .offset(y: topOffset >= 140 ? 0 : -(-topOffset + 150))
                .zIndex(0)
                // Clipping to avoid background overlay
                .clipped()
                .opacity(getOpacity())
                
            }
            .colorScheme(.dark)
            .cornerRadius(12)
            .opacity(getOpacity())
            // Stopping view at 140
            .offset(y: topOffset >= 140 ? 0 : -topOffset + 140)
            .background(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let maxY = proxy.frame(in: .global).maxY
                    
                    
                    DispatchQueue.main.async {
                        self.topOffset = minY
                        self.bottomOffset = maxY - 140
                    }
                    
                    return Color.clear
                }
            )
            .modifier(CornerModifier(bottomOffset: $bottomOffset))

    }
    
    // MARK: Methods
    /**
     A function that returns the opacity value, depending on the view's bottomOffset property.
     
     - Returns: A CGFloat containing the opacity value, depending on the view's bottomOffset property. Will return 1 if the bottomOffset is greater than 28.
     */
    func getOpacity() -> CGFloat {
        if bottomOffset < 28 {
            let progress = bottomOffset / 28
            return progress
        }
        return 1
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
