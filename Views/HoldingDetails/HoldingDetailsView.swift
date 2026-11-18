
import SwiftUI
import SwiftData

struct HoldingDetailsView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var holding: Holding

    @State private var showDeleteAlert = false
    @State private var errorMessage = ""

    private let viewModel = HoldingViewModel()

    var body: some View {

        List {

            Section("Investment Information") {

                detailRow("Name", holding.name)
                detailRow("Type", holding.type)

                detailRow(
                    "Quantity",
                    holding.quantity.formatted()
                )

                detailRow(
                    "Purchase Price",
                    holding.buyPrice.formatted(.currency(code: "INR"))
                )

                detailRow(
                    "Latest Price",
                    holding.latestPrice.formatted(.currency(code: "INR"))
                )

                detailRow(
                    "Purchase Date",
                    holding.buyDate.formatted(date: .abbreviated, time: .omitted)
                )
            }

            Section("Investment Performance") {

                detailRow(
                    "Invested Amount",
                    holding.investedAmount.formatted(.currency(code: "INR"))
                )

                detailRow(
                    "Current Value",
                    holding.currentValue.formatted(.currency(code: "INR"))
                )

                detailRow(
                    "Profit / Loss",
                    holding.profitLoss.formatted(.currency(code: "INR"))
                )

                detailRow("Status", holding.status)
            }

            Section("Notes") {
                Text(holding.notes.isEmpty ? "No notes added." : holding.notes)
            }

            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }

            Section {

                NavigationLink("Edit Investment") {
                    EditHoldingView(holding: holding)
                }

                Button("Delete Investment", role: .destructive) {
                    showDeleteAlert = true
                }
            }
        }
        .navigationTitle(holding.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Investment?", isPresented: $showDeleteAlert) {

            Button("Cancel", role: .cancel) {}

            Button("Delete", role: .destructive) {
                deleteHolding()
            }

        } message: {
            Text("This investment will be permanently deleted from this device.")
        }
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }

    private func deleteHolding() {

        do {
            try viewModel.deleteHolding(
                context: context,
                holding: holding
            )

            dismiss()

        } catch {
            errorMessage = "Unable to delete investment: \(error.localizedDescription)"
        }
    }
}

