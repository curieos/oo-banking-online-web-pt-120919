class Transfer
  attr_reader :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end
  
  def valid?()
    sender.valid? && receiver.valid?
  end
  
  def execute_transaction()
    return if @status != "pending" 
    if !self.valid? || @sender.balance - @amount < 0
      @status = "rejected"
      return "Transaction rejected. Please check your account balance." 
    end
    @sender.withdraw(amount)
    @receiver.deposit(amount)
    @status = "complete"
  end
  
  def reverse_transfer
    return if @status != "complete"
    @sender.deposit(amount)
    @receiver.withdraw(amount)
    @status = "reversed"
  end
end
