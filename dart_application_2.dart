class BankAccount {
  String _accountNumber;
  String _accountOwner;
  double _balance=0.0;


  // Конструктор для инициализации
  BankAccount(this._accountNumber, this._accountOwner, double initialBalance) {
    _balance = initialBalance;
  }


  // Геттер для получения текущего баланса
  double get balance => _balance;


  // Метод для внесения денег на сче
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('$amount успешно зачислено на счет. Новый баланс: $_balance');
    } else {
      print('Неверная сумма для зачисления.');
    }
  }


  // Метод для снятия денег со счета
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('$amount успешно снято со счета. Новый баланс: $_balance');
    } else {
      print('Неверная сумма для снятия или недостаточно средств.');
    }
  }


  // Метод для получения текущего баланса
  double getBalance() {
    return _balance;
  }


  // Метод для вывода информации о счете
  void displayAccountInfo() {
    print('Номер счета: $_accountNumber');
    print('Владелец счета: $_accountOwner');
    print('Текущий баланс: $_balance');
  }
}


void main() {
  // Пример использования класса BankAccount
  var account = BankAccount('1234567890', 'Иван Иванов', 1000.0);
  account.displayAccountInfo();


  account.deposit(500.0);
  account.withdraw(200.0);
  account.withdraw(2000.0);
}


