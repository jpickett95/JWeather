//
//  PressureView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

struct PressureView: View {
    private let presenter: PressurePresentable
    
    init(presenter: PressurePresentable) {
        self.presenter = presenter
    }
    
    var body: some View {
        CustomStackView {
            
            Label {
                
                Text(presenter.title)
                
            } icon: {
                
                Image(systemName: presenter.icon)
                
            }
            
        } contentView: {
            ZStack{
                // MARK: Content Image
                Image(systemName: "tirepressure")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 100))
                
                // MARK: Content
                VStack{
                    Text(presenter.pressure ?? "N/A")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                    Text("inHg")
                        .foregroundStyle(.white)
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
