import Foundation
import CoreData

@objc(TransactionType)
public class TransactionType: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var transactions: NSSet?
}

extension TransactionType {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionType> {
        return NSFetchRequest<TransactionType>(entityName: "TransactionType")
    }
}
