//
//  SunsetView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Weather Data View
struct WeatherDataView: View {
    
    
    // MARK: Properties
    private let presenter: WeatherDataPresentable
    
    
    // MARK: Lifecycle
    init(presenter: WeatherDataPresentable) {
        self.presenter = presenter
    }
    
    // MARK: Body
    var body: some View {
        CustomStackView {
            
            // MARK: Title & Icon
            Label {
                Text(presenter.title.rawValue)
            } icon: {
                Image(systemName: presenter.icon.rawValue)
            }
            
        } contentView: {
            
            // MARK: Content
            VStack(alignment: .leading, spacing: 10) {
                
                
                // MARK: Data
                Text(presenter.switchContent())
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // MARK: Description
                Text(presenter.switchDescription())
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
