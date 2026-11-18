
import Foundation
import Combine

@MainActor
final class AuthenticationViewModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""

    private let authenticationService = AuthenticationService()
    private let biometricService = BiometricService()
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func login() {

        let success = authenticationService.login(
            username: username,
            password: password
        )

        if success {
            errorMessage = ""
            appState.login()
        } else {
            errorMessage = "Invalid username or password."
        }
    }

    func loginWithBiometrics() {

        biometricService.authenticate { [weak self] success, error in

            guard let self else { return }

            if success {
                self.errorMessage = ""
                self.appState.login()
            } else {
                self.errorMessage = error ?? "Authentication failed."
            }
        }
    }
}

