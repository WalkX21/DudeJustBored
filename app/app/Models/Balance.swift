import Foundation

struct Balance: Identifiable, Codable {
    let id: UUID
    var amount: Double
    let currency: Currency
    //var cash: Double? // Optional for MAD
    //var card: Double? // Optional for MAD
}
