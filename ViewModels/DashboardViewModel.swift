import Foundation

struct DashboardViewModel {

    func totalInvested(_ holdings: [Holding]) -> Double {
        holdings.reduce(0) {
            $0 + $1.investedAmount
        }
    }

    func totalCurrentValue(_ holdings: [Holding]) -> Double {
        holdings.reduce(0) {
            $0 + $1.currentValue
        }
    }

    func totalProfitLoss(_ holdings: [Holding]) -> Double {
        totalCurrentValue(holdings) - totalInvested(holdings)
    }

    func totalHoldings(_ holdings: [Holding]) -> Int {
        holdings.count
    }

    func profitLossPercentage(_ holdings: [Holding]) -> Double {

        let invested = totalInvested(holdings)

        guard invested > 0 else {
            return 0
        }

        return totalProfitLoss(holdings) / invested * 100
    }
}
