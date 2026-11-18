
import Foundation
import SwiftData

@MainActor
final class HoldingViewModel {

    func addHolding(
        context: ModelContext,
        name: String,
        type: String,
        quantity: Double,
        buyPrice: Double,
        latestPrice: Double,
        buyDate: Date,
        notes: String
    ) throws {

        let holding = Holding(
            name: name,
            type: type,
            quantity: quantity,
            buyPrice: buyPrice,
            latestPrice: latestPrice,
            buyDate: buyDate,
            notes: notes
        )

        context.insert(holding)
        try context.save()
    }

    func updateHolding(
        context: ModelContext
    ) throws {
        try context.save()
    }

    func deleteHolding(
        context: ModelContext,
        holding: Holding
    ) throws {
        context.delete(holding)
        try context.save()
    }
}
