//
//  WeatherView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack{
            // MARK: Background Image
            Image(SkyImages.clear.rawValue, bundle: nil)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                CurrentWeatherContentView()
                    
                ScrollView {
                    
                }
            }
            
            
        }
    }
}

#Preview {
    WeatherView()
}
