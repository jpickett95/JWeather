//
//  ContentBlockView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/6/24.
//

import SwiftUI

struct ContentBlockView: View {
    private let dimension = UIScreen.screenWidth / 2 - 30
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("blockBackground") .opacity(0.35))
                .frame(width: dimension, height: dimension)
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "thermometer.medium")
                        Text("Feels Like")
                        Spacer()
                    }.foregroundStyle(Color("SkyBlue"))
                        .frame(width: dimension - 20)
                        .padding(.top, 5)
            
                    HStack{
                        Text("61 mi")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                        Spacer()
                    }.frame(width: dimension - 20)
                        .padding(.top, 5)
                }
                Spacer()
                
                Text(" all go t")
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
            }.padding(10)
               
        }.frame(width: dimension, height: dimension)
    }
}

#Preview {
    ContentBlockView()
}
