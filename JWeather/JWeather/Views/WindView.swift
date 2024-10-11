//
//  WindView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Wind View
struct WindView: View {
    
    
    // MARK: Properties
    private let presenter: WindPresentable
    
    
    // MARK: Lifecycle
    init(presenter: WindPresentable) {
        self.presenter = presenter
    }
    
    // MARK: Body
    var body: some View {
        CustomStackView {
            
            // MARK: Title & Icon
            Label{
                Text(presenter.title)
            } icon: {
                Image(systemName: presenter.icon)
            }
            
        } contentView: {
            
            // MARK: Content
            HStack(spacing: 10){
                VStack(alignment: .leading ,spacing: 5) {
                    
                    // MARK: Wind Speed
                    VStack {
                        HStack{
                            Text("\(Int(presenter.windSpeed ?? 0))")
                                .foregroundStyle(.white)
                                .font(.system(size: 45))
                            
                            VStack {
                                Text("MPH")
                                    .foregroundStyle(.white.opacity(0.6))
                                Text("Wind")
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    
                    Divider()
                        .overlay(.white)
                    
                    // MARK: Wind Gusts
                    VStack {
                        HStack{
                            Text("\(Int(presenter.windGusts ?? 0))")
                                .foregroundStyle(.white)
                                .font(.system(size: 45))
                            
                            VStack {
                                Text("MPH")
                                    .foregroundStyle(.white.opacity(0.6))
                                Text("Gusts")
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
                
                // MARK: Wind Direction
                VStack(spacing: 5){
                    Text(presenter.switchDegreesToDirection(Double(presenter.degrees ?? 0)))
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    ZStack {
                        Image(systemName: "circle.dotted")
                            .foregroundStyle(.white.opacity(0.5))
                            .font(.system(size: 80))
                        
                        Image(systemName: "location.north.fill")
                            .foregroundStyle(.white.opacity(0.7))
                            .font(.system(size: 40))
                            .rotationEffect(.degrees(Double(presenter.degrees ?? 0)))
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
