import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var transactionDescription: String?
    @NSManaged public var user: User?
    @NSManaged public var transactionType: TransactionType?
}

extension Transaction {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }
}
