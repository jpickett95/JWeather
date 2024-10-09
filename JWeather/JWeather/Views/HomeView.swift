//
//  HomeView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    
    var body: some View {
        ZStack {
            
            // Geometry Reader for getting width & height
            GeometryReader { proxy in
                Image("clear-sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            //.overlay(.ultraThinMaterial)    // Blur effect
            
            // Main View
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    // Current Weather Data
                    VStack(alignment: .center, spacing: 5) {
                        
                        Text("My Location")
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        
                        Text(" 98°")
                            .font(.system(size: 75, weight: .thin))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        Text("Clear")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        
                        Text("H:100°  L:95°")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                    }
                    .offset(y: -offset)
                    // For bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    // Custom Data Views
                    VStack(spacing: 10) {
                        
                        // Custom Stack Views
                        
                        CustomStackView {
                            // Label here:
                            Label {
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                            
                        } contentView: {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 15) {
                                    ForecastView(time: "Now", temp: 93, image: "cloud.bolt")
                                    ForecastView(time: "12PM", temp: 94, image: "sun.max")
                                    ForecastView(time: "1PM", temp: 95, image: "sun.min")
                                    ForecastView(time: "2PM", temp: 96, image: "sun.haze")
                                    ForecastView(time: "3PM", temp: 97, image: "cloud.sun")
                                    ForecastView(time: "4PM", temp: 98, image: "cloud")
                                    ForecastView(time: "5PM", temp: 99, image: "cloud.rain")
                                    ForecastView(time: "6PM", temp: 100, image: "cloud.fog")
                                }
                            }
                        }
                        
                        // Weather Data View
                        
                        ForEach(0..<10) { _ in
                            
                            
                            WeatherDataView()
                            
                        }
                    }
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                // Getting offset
                .overlay(
                    // Using Geometry Reader
                    GeometryReader { proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        
                        return Color.clear
                        
                    }
                )
            }
        }
    }
    
    func getTitleOpacity() -> CGFloat {
        let titleOffet = -getTitleOffset()
        
        let progress = titleOffet / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    func getTitleOffset() -> CGFloat {
        // Setting one max height for whole title
        // Consider max as 120
        if offset < 0 {
            let progress = -offset / 120
            
            // Since top padding is 25
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            
            return -newOffset
        }
        
        return 0
    }
}

#Preview {
    ContentView()
}

struct ForecastView: View {
    var time: String
    var temp: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.title2)
            // Multicolor
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            // Max frame
                .frame(height: 30)
            
            Text("\(Int(temp))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
