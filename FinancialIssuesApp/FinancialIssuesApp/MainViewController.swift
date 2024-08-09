import UIKit
import CoreData

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch current user and balances
        fetchCurrentUser()
        updateUI()
    }
    
    func fetchCurrentUser() {
        // Implement Core Data fetch request to get the current user
        // Set currentUser
        currentUser = CoreDataHelper.shared.fetchUser(username: "currentUsername")
    }
    
    func updateUI() {
        guard let user = currentUser else { return }
        welcomeLabel.text = "Welcome back, \(user.username)"
        // Fetch and display balances
        let balances = CoreDataHelper.shared.fetchBalances(for: user)
        // Update balanceLabel with balances
    }
    
    @IBAction func registerNewBalanceTapped(_ sender: UIButton) {
        // Show balance registration screen
    }
    
    @IBAction func registerTransactionTapped(_ sender: UIButton) {
        // Show transaction registration screen
    }
}
