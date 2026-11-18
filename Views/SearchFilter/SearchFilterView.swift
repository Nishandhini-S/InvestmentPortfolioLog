
import SwiftUI

struct SearchFilterView: View {

    @Binding var searchText: String
    @Binding var selectedType: String

    private let investmentTypes = [
        "All",
        "Stock",
        "Mutual Fund",
        "Gold",
        "Fixed Deposit"
    ]

    var body: some View {

        VStack(spacing: 10) {

            TextField("Search investments...", text: $searchText)
                .textFieldStyle(.roundedBorder)

            Picker("Investment Type", selection: $selectedType) {
                ForEach(investmentTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

