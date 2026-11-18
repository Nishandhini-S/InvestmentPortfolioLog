
import SwiftUI

struct SummaryCardView: View {

    let title: String
    let value: String
    let symbol: String
    let color: Color

    var body: some View {

        HStack(spacing: 15) {

            Image(systemName: symbol)
                .font(.title)
                .foregroundStyle(color)
                .frame(width: 45)

            VStack(alignment: .leading, spacing: 6) {

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

