import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    private var users: [User] = []
    
    init() {
        loadUsers()
    }
    
    func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let savedUsers = try? JSONDecoder().decode([User].self, from: data) {
            users = savedUsers
        }
    }
    
    func saveUsers() {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: "users")
        }
    }
    
    func login() {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            isLoggedIn = true
            errorMessage = ""
        } else {
            errorMessage = "Invalid email or password."
        }
    }
    
    func signUp() {
        if users.contains(where: { $0.email == email }) {
            errorMessage = "Email already in use."
            return
        }
        
        let newUser = User(id: UUID(), name: name, email: email, password: password)
        users.append(newUser)
        saveUsers()
        isLoggedIn = true
        errorMessage = ""
    }
}
