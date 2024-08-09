import Foundation
import Combine

class DatabaseManager {
    private let baseURL = "http://10.0.1.193:5000" // Use the IP address from your Flask server

    // Sign up a new user
    func signUp(name: String, email: String, password: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["name": name, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Log in an existing user
    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: User.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Load balances for a specific user
    func loadBalances(forUserId userId: String) -> AnyPublisher<[Balance], Error> {
        let url = URL(string: "\(baseURL)/balances/\(userId)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Balance].self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Save balances for a specific user
    func saveBalances(balances: [Balance], forUserId userId: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/balances/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = balances.map { ["currency": $0.currency, "amount": $0.amount] }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Load transactions for a specific user
    func loadTransactions(forUserId userId: String) -> AnyPublisher<[Transaction], Error> {
        let url = URL(string: "\(baseURL)/transactions/\(userId)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Save transactions for a specific user
    func saveTransactions(transactions: [Transaction], forUserId userId: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/transactions/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = transactions.map { ["type": $0.type, "amount": $0.amount, "description": $0.description, "date": $0.date] }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
