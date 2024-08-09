import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var user: User? // This can be used to store the logged-in user
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    private let databaseManager: DatabaseManager
    private var cancellables = Set<AnyCancellable>()

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func login(email: String, password: String) {
        databaseManager.login(email: email, password: password)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Invalid email or password."
                    print("Error logging in: \(error)")
                }
            }, receiveValue: { user in
                self.isLoggedIn = true
                self.user = user
            })
            .store(in: &cancellables)
    }

    func signUp(name: String, email: String, password: String) {
        databaseManager.signUp(name: name, email: email, password: password)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error signing up: \(error)")
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
}
