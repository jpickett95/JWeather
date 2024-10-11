//
//  PressureView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Pressure View
struct PressureView: View {
    
    
    // MARK: Properties
    private let presenter: PressurePresentable
    
    
    // MARK: Lifecycle
    init(presenter: PressurePresentable) {
        self.presenter = presenter
    }
    
    // MARK: Body
    var body: some View {
        CustomStackView {
            
            // MARK: Title & Icon
            Label {
                Text(presenter.title)
            } icon: {
                Image(systemName: presenter.icon)
            }
            
        } contentView: {
            
            //MARK: Content
            ZStack{
                
                
                // MARK: Image
                Image(systemName: "tirepressure")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 100))
                
                // MARK: Pressure
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
