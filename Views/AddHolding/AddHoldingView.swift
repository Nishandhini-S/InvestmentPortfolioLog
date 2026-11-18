
import SwiftUI
import SwiftData

struct AddHoldingView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var type = "Stock"
    @State private var quantity = ""
    @State private var buyPrice = ""
    @State private var latestPrice = ""
    @State private var buyDate = Date()
    @State private var notes = ""

    @State private var errorMessage = ""

    private let viewModel = HoldingViewModel()

    private let types = [
        "Stock",
        "Mutual Fund",
        "Gold",
        "Fixed Deposit"
    ]

    var body: some View {

        Form {

            Section("Investment Information") {

                TextField("Investment Name", text: $name)

                Picker("Investment Type", selection: $type) {
                    ForEach(types, id: \.self) { item in
                        Text(item)
                    }
                }

                TextField("Quantity", text: $quantity)
                    .keyboardType(.decimalPad)

                TextField("Purchase Price (₹)", text: $buyPrice)
                    .keyboardType(.decimalPad)

                TextField("Latest Price (₹)", text: $latestPrice)
                    .keyboardType(.decimalPad)

                DatePicker(
                    "Purchase Date",
                    selection: $buyDate,
                    displayedComponents: .date
                )
            }

            Section("Notes") {
                TextField("Additional notes", text: $notes, axis: .vertical)
                    .lineLimit(3...5)
            }

            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button("Save Investment") {
                    saveHolding()
                }
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
            }
        }
        .navigationTitle("Add Investment")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func saveHolding() {

        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter the investment name."
            return
        }

        guard
            let quantityValue = Double(quantity),
            let buyPriceValue = Double(buyPrice),
            let latestPriceValue = Double(latestPrice),
            quantityValue > 0,
            buyPriceValue > 0,
            latestPriceValue >= 0
        else {
            errorMessage = "Enter valid positive quantity and prices."
            return
        }

        do {
            try viewModel.addHolding(
                context: context,
                name: name.trimmingCharacters(in: .whitespaces),
                type: type,
                quantity: quantityValue,
                buyPrice: buyPriceValue,
                latestPrice: latestPriceValue,
                buyDate: buyDate,
                notes: notes
            )

            dismiss()

        } catch {
            errorMessage = "Unable to save investment: \(error.localizedDescription)"
        }
    }
}

