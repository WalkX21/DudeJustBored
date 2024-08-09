import Foundation
import SQLite3

class DataModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    var db: OpaquePointer?
    @Published var currentUser: User?

    init() {
        openDatabase()
        createTables()
    }

    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MoneyApp.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }

    func createTables() {
        let createUserTableString = """
        CREATE TABLE IF NOT EXISTS User(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Username TEXT,
        Password TEXT,
        BalanceUSD REAL,
        BalanceMAD REAL,
        BalanceEUR REAL);
        """
        
        let createTransactionTableString = """
        CREATE TABLE IF NOT EXISTS UserTransaction(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        UserId INTEGER,
        Description TEXT,
        Amount REAL,
        Date TEXT,
        Type TEXT,
        Currency TEXT,
        FOREIGN KEY(UserId) REFERENCES User(Id));
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createUserTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("User table created.")
            } else {
                print("User table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)

        if sqlite3_prepare_v2(db, createTransactionTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("UserTransaction table created.")
            } else {
                print("UserTransaction table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func createUser(username: String, password: String) {
        let insertStatementString = "INSERT INTO User (Username, Password, BalanceUSD, BalanceMAD, BalanceEUR) VALUES (?, ?, 0, 0, 0);"
        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, username, -1, nil)
            sqlite3_bind_text(insertStatement, 2, password, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted user.")
            } else {
                print("Could not insert user.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func authenticate(username: String, password: String) -> Bool {
        let queryStatementString = "SELECT * FROM User WHERE Username = ? AND Password = ?;"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, username, -1, nil)
            sqlite3_bind_text(queryStatement, 2, password, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let balanceUSD = sqlite3_column_double(queryStatement, 3)
                let balanceMAD = sqlite3_column_double(queryStatement, 4)
                let balanceEUR = sqlite3_column_double(queryStatement, 5)

                currentUser = User(id: Int(id), username: username, balanceUSD: balanceUSD, balanceMAD: balanceMAD, balanceEUR: balanceEUR)
                fetchTransactions() // Fetch transactions for the current user
                return true
            } else {
                print("User not found.")
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        return false
    }

    func updateBalance(amount: Double, currency: String) {
        guard var currentUser = currentUser else { return }
        switch currency {
        case "USD":
            currentUser.balanceUSD += amount
        case "MAD":
            currentUser.balanceMAD += amount
        case "EUR":
            currentUser.balanceEUR += amount
        default:
            return
        }
        self.currentUser = currentUser
        updateBalanceInDatabase(for: currentUser)
    }

    func updateBalanceInDatabase(for user: User) {
        let updateStatementString = "UPDATE User SET BalanceUSD = ?, BalanceMAD = ?, BalanceEUR = ? WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(updateStatement, 1, user.balanceUSD)
            sqlite3_bind_double(updateStatement, 2, user.balanceMAD)
            sqlite3_bind_double(updateStatement, 3, user.balanceEUR)
            sqlite3_bind_int(updateStatement, 4, Int32(user.id))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated balance.")
            } else {
                print("Could not update balance.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }

    func addTransaction(description: String, amount: Double, date: String, type: String, currency: String) {
        guard let currentUser = currentUser else { return }
        let insertStatementString = "INSERT INTO UserTransaction (UserId, Description, Amount, Date, Type, Currency) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(currentUser.id))
            sqlite3_bind_text(insertStatement, 2, description, -1, nil)
            sqlite3_bind_double(insertStatement, 3, amount)
            sqlite3_bind_text(insertStatement, 4, date, -1, nil)
            sqlite3_bind_text(insertStatement, 5, type, -1, nil)
            sqlite3_bind_text(insertStatement, 6, currency, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted transaction.")
                fetchTransactions() // Fetch transactions after adding a new one
            } else {
                print("Could not insert transaction.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func fetchTransactions() {
        guard let currentUser = currentUser else { return }
        let queryStatementString = "SELECT * FROM UserTransaction WHERE UserId = ?;"
        var queryStatement: OpaquePointer? = nil
        var transactions: [Transaction] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(currentUser.id))

            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let amount = sqlite3_column_double(queryStatement, 3)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let currency = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))

                let transaction = Transaction(id: Int(id), userId: currentUser.id, description: description, amount: amount, date: date, type: type, currency: currency)
                transactions.append(transaction)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        self.transactions = transactions
    }
}
