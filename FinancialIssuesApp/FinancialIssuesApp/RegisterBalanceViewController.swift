import UIKit
import CoreData

class RegisterBalanceViewController: UIViewController {
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let currency = currencyTextField.text ?? ""
        let amount = Double(amountTextField.text ?? "") ?? 0.0
        let type = typeSegmentedControl.selectedSegmentIndex == 0 ? "cash" : "card"
        
        // Save balance to Core Data
        // Implement Core Data save request here
    }
}
