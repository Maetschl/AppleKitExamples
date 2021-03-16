//
//  ContentView.swift
//  LoginExample
//
//  Created by Julian Arias Maetschl on 16-03-21.
//

import SwiftUI

struct LoggedView: View {
    @ObservedObject var loginManager: LoginManager

    var body: some View {
        VStack {
            Text("Please login")
                .padding()
            Button("Login", action: {
                loginManager.isLogged.toggle()
            })
        }
    }
}

struct LoginView: View {
    @ObservedObject var loginManager: LoginManager

    var body: some View {
        VStack {
            VStack {
                Text("You are logged")
                    .padding()
                Button("Logout") {
                    loginManager.isLogged.toggle()
                }
            }
        }
    }
}

class LoginManager: ObservableObject {

    @Published var isLogged: Bool

    init() {
        isLogged = true
    }
}

struct ContentView: View {

    @StateObject var loginManager = LoginManager()

    var body: some View {
        if loginManager.isLogged {
            LoggedView(loginManager: loginManager)
        } else {
            LoginView(loginManager: loginManager)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
