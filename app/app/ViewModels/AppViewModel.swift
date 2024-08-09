import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var userBalances: [Balance] = [] // Balances specific to the logged-in user
    @Published var userTransactions: [Transaction] = [] // Transactions specific to the logged-in user
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
                self.loadUserData(forUserId: user.id)
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

    func loadUserData(forUserId userId: String) {
        databaseManager.loadBalances(forUserId: userId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error loading balances: \(error)")
                }
            }, receiveValue: { balances in
                self.userBalances = balances
            })
            .store(in: &cancellables)

        databaseManager.loadTransactions(forUserId: userId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error loading transactions: \(error)")
                }
            }, receiveValue: { transactions in
                self.userTransactions = transactions
            })
            .store(in: &cancellables)
    }

    func addOrUpdateBalance(amount: Double, currency: String) {
        if let index = userBalances.firstIndex(where: { $0.currency == currency }) {
            userBalances[index].amount = amount // Update existing balance
        } else {
            let newBalance = Balance(currency: currency, amount: amount)
            userBalances.append(newBalance) // Add new balance if it doesn't exist
        }
        
        if let userId = user?.id {
            databaseManager.saveBalances(balances: userBalances, forUserId: userId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error saving balances: \(error)")
                    }
                }, receiveValue: { })
                .store(in: &cancellables)
        }
    }

    func addTransaction(type: String, amount: Double, description: String, date: String) {
        let newTransaction = Transaction(id: UUID(), type: type, amount: amount, description: description, date: date)
        userTransactions.append(newTransaction)

        if let userId = user?.id {
            databaseManager.saveTransactions(transactions: userTransactions, forUserId: userId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error saving transactions: \(error)")
                    }
                }, receiveValue: { })
                .store(in: &cancellables)
        }
    }
}
