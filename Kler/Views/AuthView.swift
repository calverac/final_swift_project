//
//  AuthView.swift
//  Kler
//
//  Created by Catalina on 12/1/25.
//

import SwiftUI
import SwiftData

struct AuthView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var isLoginMode = true

    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 40)

            Text("KLER")
                .font(.system(size: 40, weight: .bold))
            
            Spacer()
            
            Image("kler_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(.bottom, 10)

            Spacer()
            
            VStack(spacing: 12) {
                TextField("Email", text: $authVM.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $authVM.password)
                    .textFieldStyle(.roundedBorder)

                if !isLoginMode {
                    TextField("Display name (optional)", text: $authVM.displayName)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.horizontal)

            Button(isLoginMode ? "Sign In" : "Create Account") {
                Task {
                    if isLoginMode {
                        await authVM.signIn()
                    } else {
                        await authVM.signUp()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.teal)
            .padding(.horizontal)

            .buttonStyle(.borderedProminent)
            .tint(.teal)
            .padding(.horizontal)

            Button(isLoginMode ? "Create an account" : "Already have an account?") {
                isLoginMode.toggle()
            }
            .font(.footnote)

            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
        .modelContainer(for: ClothingItem.self, inMemory: true)
}
