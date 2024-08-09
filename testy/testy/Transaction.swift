import Foundation

struct Transaction: Identifiable {
    var id: Int
    var userId: Int
    var description: String
    var amount: Double
    var date: String
    var type: String
    var currency: String
}
