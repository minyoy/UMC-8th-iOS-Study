class BankAccount {
    let accountNumber: String
    private var balance: Double
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        
        if (initialBalance < 0) {
            self.balance = 0
        } else {
            self.balance = initialBalance
        }
    }
    
    func deposit(amount: Double) {
        self.balance += amount
        print("Deposited \(amount). Current balance: \(self.balance)")
    }
    
    func withdraw(amount: Double) {
        if (self.balance < amount) {
            print("Insufficient funds. Current balance: \(self.balance)")
        } else {
            self.balance -= amount
            print("Deposited \(amount). Current balance: \(self.balance)")
        }
    }
}

/* 코드 시나리오, 위 클래스 구현 후 실행 시켜주세요! */

let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)

account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"
