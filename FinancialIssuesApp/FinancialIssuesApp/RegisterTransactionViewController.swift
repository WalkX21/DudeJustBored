import UIKit
import CoreData

class RegisterTransactionViewController: UIViewController {
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let type = typeSegmentedControl.selectedSegmentIndex == 0 ? "income" : "expense"
        let currency = currencyTextField.text ?? ""
        let amount = Double(amountTextField.text ?? "") ?? 0.0
        let descriptionn = descriptionTextField.text ?? ""
        
        // Save transaction to Core Data
        if let user = CoreDataHelper.shared.fetchUser(username: "currentUsername") {
            CoreDataHelper.shared.saveTransaction(type: type, currency: currency, amount: amount, descriptionn: descriptionn, for: user)
        }
    }
}
