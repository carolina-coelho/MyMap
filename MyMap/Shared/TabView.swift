import SwiftUI

struct TabViewContent: View {
    @StateObject private var visitedCountriesModel = VisitedCountriesModel()
    
    var body: some View {
        TabView{
            Tab("Home", systemImage:"house"){
                HomeView()
            }

            Tab("Add", systemImage:"plus.circle"){
                AddView()
                .environmentObject(visitedCountriesModel)
            }

            Tab("Visited", systemImage:"airplane"){
                VisitedView()
                .environmentObject(visitedCountriesModel)
            }

            Tab("Profile", systemImage:"person.crop.circle.fill"){
                ProfileView()
                .environmentObject(visitedCountriesModel)
            }
        }
    }
}

