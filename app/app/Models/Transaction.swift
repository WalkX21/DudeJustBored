import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    let type: TransactionType
    let amount: Double
    let date: Date
    let description: String
    let category: String
}

