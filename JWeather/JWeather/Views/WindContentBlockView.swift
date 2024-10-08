//
//  SwiftUIView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import SwiftUI

struct WindContentBlockView: View {
    // MARK: Properties
    private let presenter: WindContentBlockPresenter
    private let dimension = UIScreen.screenWidth - 40
    
    // MARK: Lifecycle
    init(presenter: WindContentBlockPresenter) {
        self.presenter = presenter
    }

    var body: some View {
        ZStack {
            // MARK: Background
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("blockBackground") .opacity(0.35))
                .frame(width: dimension, height: dimension / 2)
            
            // MARK: Title
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: presenter.iconImage)
                        Text(presenter.title)
                        Spacer()
                    }.foregroundStyle(Color("SkyBlue"))
                        .frame(width: dimension - 20)
                        .padding(.top, 5)
            
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
                                            .foregroundStyle(Color("SkyBlue"))
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
                                            .foregroundStyle(Color("SkyBlue"))
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
                                
                                Image(systemName: "location.north")
                                    .foregroundStyle(.white.opacity(0.7))
                                    .font(.system(size: 40))
                                    .rotationEffect(.degrees(Double(presenter.degrees ?? 0)))
                            }
                            
                        }.frame(width: dimension - 250)
                    }.frame(width: dimension - 20)
                        .padding([.top,.bottom], 5)
                }
               
            }.padding(10)
            
        }.frame(width: dimension, height: dimension / 2)
    }
}

#Preview {
    WindContentBlockView(presenter: WindContentBlockPresenter(interactor: WeatherInteractor(networkService: NetworkService(), locationService: LocationService())))
}
