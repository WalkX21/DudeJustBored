import Foundation

struct TransactionCategory: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let emoji: String
}
