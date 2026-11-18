
import SwiftUI
import SwiftData

@main
struct InvestmentPortfolioLogApp: App {

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .modelContainer(for: Holding.self)
    }
}
