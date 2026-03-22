import SwiftUI
import PhotosUI 

struct ProfileView: View {
    
    @EnvironmentObject var visitedCountriesModel: VisitedCountriesModel
    @EnvironmentObject var authManager: AuthManager
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil

    
    let profile = Profile(name:"Sofia", age:21, favCountry:"Portugal",
                         countriesVisited: ["Portugal", "Spain", "France"],
                         citiesvisited: ["Lisbon", "Madrid", "Paris", "Tokyo"])
    
    var body: some View {
        let totalCountries = 195.0
        let totalCities = 38000.0
        let countriesVisited = visitedCountriesModel.visitedCountries.count
        let citiesVisited = visitedCountriesModel.visitedCountries.flatMap { $0.cities }.count
        let percentCountries = Double(countriesVisited) / totalCountries
        let percentCities = Double(citiesVisited) / totalCities
        
        ScrollView {
            VStack(spacing: 16) {
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    ZStack(alignment: .bottomTrailing) {
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .background(Color.white.clipShape(Circle()))
                    }
                }
                .padding(.top, 20)
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                profileImage = uiImage
                            }
                        }
                    }
                }
                
                Text(profile.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                    
                    HStack {
                        Text("Full Name:")
                            .foregroundColor(.gray)
                        Text(profile.name)
                    }
                    HStack {
                        Text("Age:")
                            .foregroundColor(.gray)
                        Text("\(profile.age)")
                    }
                    HStack {
                        Text("Favorite Country:")
                           .foregroundColor(.gray)
                        Text(profile.favCountry)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("% Countries Visited")
                        .font(.headline)
                    ProgressView(value: percentCountries)
                        .tint(.purple)
                    
                    Text("% Cities Visited")
                        .font(.headline)
                    ProgressView(value: percentCities)
                        .tint(.purple)
                }
                .padding(.horizontal)
            }
            Button(action: {
                authManager.signOut()
            }) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }.accessibilityIdentifier("btnLogout")
            .padding()
        }
    }
}
