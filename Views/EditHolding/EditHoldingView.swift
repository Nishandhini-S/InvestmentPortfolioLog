
import SwiftUI
import SwiftData

struct EditHoldingView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var holding: Holding

    @State private var errorMessage = ""

    private let viewModel = HoldingViewModel()

    var body: some View {

        Form {

            Section("Update Investment") {

                TextField("Investment Name", text: $holding.name)

                TextField(
                    "Quantity",
                    value: $holding.quantity,
                    format: .number
                )
                .keyboardType(.decimalPad)

                TextField(
                    "Latest Price (₹)",
                    value: $holding.latestPrice,
                    format: .number
                )
                .keyboardType(.decimalPad)

                TextField("Notes", text: $holding.notes, axis: .vertical)
                    .lineLimit(3...5)
            }

            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
            }

            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Edit Investment")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func saveChanges() {

        guard
            !holding.name.trimmingCharacters(in: .whitespaces).isEmpty,
            holding.quantity > 0,
            holding.latestPrice >= 0
        else {
            errorMessage = "Please enter a valid name, quantity and latest price."
            return
        }

        do {
            try viewModel.updateHolding(context: context)
            dismiss()

        } catch {
            errorMessage = "Unable to update investment: \(error.localizedDescription)"
        }
    }
}

