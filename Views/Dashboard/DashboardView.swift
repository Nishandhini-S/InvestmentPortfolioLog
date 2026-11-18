
import SwiftUI
import SwiftData

struct DashboardView: View {

    @EnvironmentObject private var appState: AppState

    @Query(sort: \Holding.name)
    private var holdings: [Holding]

    private let viewModel = DashboardViewModel()

    private var totalProfit: Double {
        viewModel.totalProfitLoss(holdings)
    }

    private func formatMoney(_ amount: Double) -> String {
        amount.formatted(.currency(code: "INR"))
    }

    var body: some View {

        NavigationStack {
            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Investment Portfolio")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Track your investments easily")
                            .foregroundStyle(.secondary)
                    }

                    SummaryCardView(
                        title: "Total Holdings",
                        value: "\(holdings.count)",
                        symbol: "briefcase.fill",
                        color: .blue
                    )

                    SummaryCardView(
                        title: "Total Invested",
                        value: formatMoney(
                            viewModel.totalInvested(holdings)
                        ),
                        symbol: "indianrupeesign.circle.fill",
                        color: .blue
                    )

                    SummaryCardView(
                        title: "Current Value",
                        value: formatMoney(
                            viewModel.totalCurrentValue(holdings)
                        ),
                        symbol: "chart.line.uptrend.xyaxis",
                        color: .purple
                    )

                    SummaryCardView(
                        title: "Overall Profit / Loss",
                        value: formatMoney(totalProfit),
                        symbol: "chart.bar.fill",
                        color: totalProfit >= 0 ? .green : .red
                    )

                    Text(
                        "Return: \(viewModel.profitLossPercentage(holdings), specifier: "%.2f")%"
                    )
                    .font(.headline)
                    .foregroundStyle(totalProfit >= 0 ? .green : .red)

                    NavigationLink {
                        HoldingsView()
                    } label: {
                        Label(
                            "View All Investments",
                            systemImage: "list.bullet"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    NavigationLink {
                        AddHoldingView()
                    } label: {
                        Label(
                            "Add Investment",
                            systemImage: "plus.circle"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)

                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Logout") {
                        appState.logout()
                    }
                }
            }
        }
    }
}

