//
//  PressureBlockView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import SwiftUI

struct PressureBlockView: View {
    private let presenter: PressureContentBlockPresenter
    private let dimension = UIScreen.screenWidth / 2 - 30

    init(presenter: PressureContentBlockPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("blockBackground") .opacity(0.35))
                .frame(width: dimension, height: dimension)
            
            VStack(alignment: .leading){
                // MARK: Title & Icon
                HStack{
                    Image(systemName: presenter.icon)
                    Text(presenter.title)
                    Spacer()
                }.foregroundStyle(Color("SkyBlue"))
                    .frame(width: dimension - 20)
                    .padding(.top, 5)
            
                
                ZStack{
                    Image(systemName: "tirepressure")
                        .foregroundStyle(.white.opacity(0.6))
                        .font(.system(size: 100))
                        .offset(y: 10)
                    
                    // MARK: Content
                    VStack{
                        Text(presenter.pressure ?? "N/A")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                        Text("inHg")
                            .foregroundStyle(.white)
                    }.frame(width: dimension - 20)
                        .padding([.bottom], 5)
                        .offset(y: 8)
                }.padding(.bottom, 10)
            }
               
        }.frame(width: dimension, height: dimension)    }
}

#Preview {
    PressureBlockView(presenter: PressureContentBlockPresenter(interactor: WeatherInteractor(networkService: NetworkService(), locationService: LocationService())))
}
