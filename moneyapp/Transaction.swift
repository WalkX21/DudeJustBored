import Foundation

struct Transaction: Identifiable {
    let id: String
    let description: String
    let amount: Double
    let currency: String
    let date: Date

    init(id: String, description: String, amount: Double, currency: String, date: Date) {
        self.id = id
        self.description = description
        self.amount = amount
        self.currency = currency
        self.date = date
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let description = dict["description"] as? String,
              let amount = dict["amount"] as? Double,
              let currency = dict["currency"] as? String,
              let timestamp = dict["date"] as? TimeInterval else { return nil }

        self.id = id
        self.description = description
        self.amount = amount
        self.currency = currency
        self.date = Date(timeIntervalSince1970: timestamp)
    }

    func toDict() -> [String: Any] {
        return [
            "id": id,
            "description": description,
            "amount": amount,
            "currency": currency,
            "date": date.timeIntervalSince1970
        ]
    }
}
