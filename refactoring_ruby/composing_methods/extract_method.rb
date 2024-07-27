# Original
def print_owing
  outstanding = 0.0

  print_banner()

  # calculate outstanding
  calculate_outstanding(outstanding)

  # print details
  print_details(outstanding)
end

#===============================================================================
def print_owing
  print_banner
  calculate_outstanding outstanding
  print_details outstanding
end

def print_banner()
  # print banner
  puts "*************************"
  puts "***** Customer Owes *****"
  puts "*************************"
end

def print_details(outstanding)
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

def calculate_outstanding
  @orders.inject(0.0) { |result, order| result += order.amount }
end
