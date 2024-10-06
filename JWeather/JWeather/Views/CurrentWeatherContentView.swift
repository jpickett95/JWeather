//
//  CurrentWeatherContentView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import SwiftUI

struct CurrentWeatherContentView: View {
    //private let presenter = CurrentWeatherContentPresenter()
    
    var body: some View {
        VStack{
            //MARK: Location
            Text("My Location")
                .foregroundStyle(.white)
                .font(.title2)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: Temperature
            Text("78°")
                .foregroundStyle(.white)
                .font(.system(size: 60))
                .offset(x: 10)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: Sky
            Text("Sunny")
                .foregroundStyle(.white)
                .font(.title3)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: High/Low
            Text("H:80°\tL:70°")
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
        }
        .padding()
    }
}

#Preview {
    CurrentWeatherContentView()
}
