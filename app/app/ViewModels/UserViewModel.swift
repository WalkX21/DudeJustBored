import Foundation
import CoreData
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchUsers()
    }

    func fetchUsers() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            users = try context.fetch(request)
        } catch {
            print("Failed to fetch users: \(error)")
        }
    }

    func addUser(username: String, email: String, password: String) {
        let newUser = User(context: context)
        newUser.username = username
        newUser.email = email
        newUser.password = password
        newUser.joinDate = Date()

        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
