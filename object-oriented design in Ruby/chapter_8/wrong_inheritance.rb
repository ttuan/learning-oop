class Worker
  def initialize(name)
    @name = name
  end

  def calculate_pay
    raise NotImplementedError, "Subclasses must implement"
  end

  def provide_benefits
    raise NotImplementedError, "Subclasses must implement"
  end

  def generate_report
    "#{@name}'s Report"
  end
end

class FullTimeWorker < Worker
  def calculate_pay
    "Full-time pay calculation"
  end

  def provide_benefits
    "Full-time benefits"
  end
end

class PartTimeWorker < Worker
  def calculate_pay
    "Part-time pay calculation"
  end

  def provide_benefits
    "Part-time benefits"
  end
end

class ContractorWorker < Worker
  def calculate_pay
    "Contractor pay calculation"
  end

  def provide_benefits
    raise NotImplementedError, "Contractors don't receive benefits"
  end
end

# Example usage:
workers = [FullTimeWorker.new("Alice"), PartTimeWorker.new("Bob"), ContractorWorker.new("Charlie")]

workers.each do |worker|
  puts worker.calculate_pay
  puts worker.provide_benefits
  puts worker.generate_report
end

# The problem with this Approach
# 1. Not All Methods are Applicable: Contractors don't receive benefits, leading to exceptions or unnecessary method definitions.
# 2. Violation of Liskov Substitution Principle: A ContractorWorker cannot fully substitute a Worker as it doesn't support all operations.
# 3. Poor Scalability: Adding new worker types with unique behaviors involves modifying the base class, violating the Open/Closed Principle.
# 4. Violation of Interface Segregation Principle: Workers are forced to implement methods that are not applicable to them.


#==========================================================================
# Solution: Use Composition Instead of Inheritance
class PayBehavior
  def calculate_pay
    raise NotImplementedError, "Subclasses must implement"
  end
end

class FullTimePay < PayBehavior
  def calculate_pay
    "Full-time pay calculation"
  end
end

class PartTimePay < PayBehavior
  def calculate_pay
    "Part-time pay calculation"
  end
end

class ContractorPay < PayBehavior
  def calculate_pay
    "Contractor pay calculation"
  end
end

class BenefitsBehavior
  def provide_benefits
    raise NotImplementedError, "Subclasses must implement"
  end
end

class FullTimeBenefits < BenefitsBehavior
  def provide_benefits
    "Full-time benefits"
  end
end

class PartTimeBenefits < BenefitsBehavior
  def provide_benefits
    "Part-time benefits"
  end
end

class NoBenefits < BenefitsBehavior
  def provide_benefits
    "No benefits for contractors"
  end
end

class Worker
  def initialize(name, pay_behavior, benefits_behavior)
    @name = name
    @pay_behavior = pay_behavior
    @benefits_behavior = benefits_behavior
  end

  def calculate_pay
    @pay_behavior.calculate_pay
  end

  def provide_benefits
    @benefits_behavior.provide_benefits
  end

  def generate_report
    "#{@name}'s Report"
  end
end

# Example usage:
full_time_worker = Worker.new("Alice", FullTimePay.new, FullTimeBenefits.new)
part_time_worker = Worker.new("Bob", PartTimePay.new, PartTimeBenefits.new)
contractor_worker = Worker.new("Charlie", ContractorPay.new, NoBenefits.new)

workers = [full_time_worker, part_time_worker, contractor_worker]

workers.each do |worker|
  puts worker.calculate_pay
  puts worker.provide_benefits
  puts worker.generate_report
end
