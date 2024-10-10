//
//  SunsetView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

struct WeatherDataView: View {
    private let presenter: WeatherDataPresentable
    
    init(presenter: WeatherDataPresentable) {
        self.presenter = presenter
    }
    
    var body: some View {
        CustomStackView {
            
            Label {
                
                Text(presenter.title.rawValue)
                
            } icon: {
                
                Image(systemName: presenter.icon.rawValue)
                
            }
            
        } contentView: {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(presenter.switchContent())
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
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
