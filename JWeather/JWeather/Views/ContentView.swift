//
//  ContentView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import SwiftUI
import CoreData

// MARK: Content View
struct ContentView: View {
    
    
    // MARK: Properties
    @EnvironmentObject  var interactor : WeatherInteractor
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    // MARK: Body
    var body: some View {
        TabView {
            
            // MARK: Home View
            Tab("Main", systemImage: "location.fill") {
                // Getting safe area using Geometry Reader
                GeometryReader { proxy in
                    let topEdge = proxy.safeAreaInsets.top
                    WeatherView(presenter: WeatherPresenter(interactor: interactor, topEdge: topEdge), isMain: true)
                        .ignoresSafeArea(.all, edges: .top)
                }
            }
            
            // MARK: Subsequent Views
            
            
            
            // MARK: - - Custom Location View
            Tab() {
                GeometryReader { proxy in
                    let topEdge = proxy.safeAreaInsets.top
                    WeatherView(presenter: WeatherPresenter(interactor: interactor, topEdge: topEdge), isMain: false)
                        .ignoresSafeArea(.all, edges: .top)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
