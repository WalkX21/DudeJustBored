import Foundation
import CoreData

@objc(Balance)
public class Balance: NSManagedObject {
    @NSManaged public var totalBalance: Double
    @NSManaged public var user: User?
}

extension Balance {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }
}
