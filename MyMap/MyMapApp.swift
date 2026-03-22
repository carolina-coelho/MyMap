import SwiftUI
import FirebaseCore
import FirebaseAuth 

@main
struct MyMapApp: App {
    
    @StateObject var authManager = AuthManager()
    @StateObject var visitedCountriesModel = VisitedCountriesModel()


    init() {
        FirebaseApp.configure() 
        
        if CommandLine.arguments.contains("-resetLogin") {
            do {
                try Auth.auth().signOut()
                print("TESTE: Logout forçado efetuado com sucesso!")
            } catch {
                print("TESTE: Erro ao tentar fazer logout: \(error)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.userSession != nil {
                    ContentView()
                        .environmentObject(authManager)
                        .environmentObject(visitedCountriesModel)
                        .accessibilityIdentifier("MainContentView")
                } else {
                    LoginView()
                        .environmentObject(authManager)               
                }
            }
        }
    }
}
