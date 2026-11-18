
import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {

    @Published var isAuthenticated = false

    func login() {
        isAuthenticated = true
    }

    func logout() {
        isAuthenticated = false
    }
}
