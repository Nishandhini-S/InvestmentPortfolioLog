
import SwiftUI
import SwiftData

struct HoldingsView: View {

    @Query(sort: \Holding.name)
    private var holdings: [Holding]

    @State private var searchText = ""
    @State private var selectedType = "All"

    private var filteredHoldings: [Holding] {
        holdings.filter { holding in

            let matchesSearch =
                searchText.isEmpty ||
                holding.name.localizedCaseInsensitiveContains(searchText)

            let matchesType =
                selectedType == "All" ||
                holding.type == selectedType

            return matchesSearch && matchesType
        }
    }

    var body: some View {

        VStack(spacing: 10) {

            SearchFilterView(
                searchText: $searchText,
                selectedType: $selectedType
            )

            if filteredHoldings.isEmpty {

                ContentUnavailableView(
                    "No Investments Found",
                    systemImage: "tray",
                    description: Text("Add an investment or change your search.")
                )

            } else {

                List {
                    ForEach(filteredHoldings) { holding in

                        NavigationLink {
                            HoldingDetailsView(holding: holding)
                        } label: {

                            VStack(alignment: .leading, spacing: 6) {

                                Text(holding.name)
                                    .font(.headline)

                                Text(holding.type)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                HStack {
                                    Text(
                                        "Value: \(holding.currentValue, format: .currency(code: "INR"))"
                                    )

                                    Spacer()

                                    Text(
                                        holding.status
                                    )
                                    .foregroundStyle(
                                        holding.profitLoss > 0 ? .green :
                                        holding.profitLoss < 0 ? .red :
                                        .secondary
                                    )
                                }
                                .font(.caption)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("My Investments")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddHoldingView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

