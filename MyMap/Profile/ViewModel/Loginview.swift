import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("MyMap Login")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .accessibilityIdentifier("emailField")

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("passwordField")

            Button(action: {
                authManager.signIn(email: email, password: password)
            }) {
                Text("Entrar")
                    .bold()
                    .frame(width: 300, height: 80)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("loginButton")
        }
        .padding()
        .accessibilityIdentifier("LoginScreen") 
    }
}
