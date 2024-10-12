//
//  CustomSearchBar.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/11/24.
//

import SwiftUI

// MARK: Custom Searchbar View

/**
 A custom searchbar View.
 */
struct CustomSearchBar: View {
    // MARK: Properties
    private let presenter: CurrentWeatherPresentable
    @State var searchText: String = ""
    @State private var isEditing = false
    
    // MARK: Lifecycle
    init(presenter: CurrentWeatherPresentable) {
        self.presenter = presenter
    }

    // MARK: Body
    var body: some View {
        HStack {
            
            // MARK: TextField
            TextField("Atlanta", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.white).opacity(0.3))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black.opacity(0.3))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.black.opacity(0.3))
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .onChange(of: searchText) {
                    self.isEditing = true
                }
                .onSubmit {
                    Task {
                        self.isEditing = false

                        do {
                            try await presenter.interactor.getGeocodingData(geocodingType: .direct, stateOrCity: searchText.trimmingCharacters(in: .whitespacesAndNewlines), limit: 1, zip: nil, lat: nil, long: nil)
                            
                            let lat = presenter.interactor.geocodingData?.first?.lat
                            let long = presenter.interactor.geocodingData?.first?.lon
                            
                            try await presenter.interactor.getWeatherData(lat: lat, long: long)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        self.searchText = ""
                    }
                }
              

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                }) {
                    Text("Cancel")
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                //.animation(.default, value: isEditing)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
