//
//  ContentBlockView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/6/24.
//

import SwiftUI

struct ContentBlockView: View {
    private let presenter: ContentBlockPresenter
    private let dimension = UIScreen.screenWidth / 2 - 30
    
    init(presenter: ContentBlockPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("blockBackground") .opacity(0.35))
                .frame(width: dimension, height: dimension)
            
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    // MARK: Title & Icon
                    HStack{
                        Image(systemName: presenter.iconString.rawValue)
                        Text(presenter.title.rawValue)
                        Spacer()
                    }.foregroundStyle(Color("SkyBlue"))
                        .frame(width: dimension - 20)
                        .padding(.top, 5)
            
                    // MARK: Content
                    HStack{
                        Text(presenter.switchContent())
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                        Spacer()
                    }.frame(width: dimension - 20)
                        .padding(.top, 5)
                }
                
                Spacer()
                
                // MARK: Description
                Text(presenter.switchDescription())
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
            }.padding(10)
               
        }.frame(width: dimension, height: dimension)
    }
}

#Preview {
    ContentBlockView(presenter: ContentBlockPresenter(interactor: WeatherInteractor(networkService: NetworkService(), locationService: LocationService()), iconString: ContentIcon.precipitation, title: ContentTitle.precipitation))
}
