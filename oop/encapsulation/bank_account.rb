class BankAccount
  def initialize(owner, balance = 0)
    @owner = owner
    @balance = balance
  end

  # Public method to deposit money
  def deposit(amount)
    if amount > 0
      @balance += amount
      puts "#{amount} deposited. New balance: #{@balance}"
    else
      puts "Invalid deposit amount"
    end
  end

  # Public method to withdraw money
  def withdraw(amount)
    if amount > 0 && amount <= @balance
      @balance -= amount
      puts "#{amount} withdrawn. New balance: #{@balance}"
    else
      puts "Invalid withdrawal amount"
    end
  end

  # Public method to display the balance
  def display_balance
    puts "The balance is #{@balance}"
  end

  # Private method to get the balance
  private
  def balance
    @balance
  end
end

# Usage
account = BankAccount.new("John Doe", 100)
account.deposit(50)
account.withdraw(30)
account.display_balance

# The following line will raise an error because balance is a private method
# puts account.balance
