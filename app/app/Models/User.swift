import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var joinDate: Date?
    @NSManaged public var transactions: NSSet?
}

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}
