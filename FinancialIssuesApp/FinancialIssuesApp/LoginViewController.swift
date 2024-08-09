import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if authenticateUser(username: username, password: password) {
            // Navigate to the main screen
            performSegue(withIdentifier: "showMainScreen", sender: self)
        } else {
            // Show error
            showAlert(message: "Invalid username or password")
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if createUser(username: username, password: password) {
            // Navigate to the main screen
            performSegue(withIdentifier: "showMainScreen", sender: self)
        } else {
            // Show error
            showAlert(message: "User already exists")
        }
    }
    
    func authenticateUser(username: String, password: String) -> Bool {
        // Fetch user from Core Data and check credentials
        // Implement Core Data fetch request here
        return true
    }
    
    func createUser(username: String, password: String) -> Bool {
        // Save new user to Core Data
        // Implement Core Data save request here
        return true
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
