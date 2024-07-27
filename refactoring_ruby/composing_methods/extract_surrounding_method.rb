def charge(amount, credit_card_number)
  begin
    connection = CreditCardServer.connect(...)
    connection.send(amount, credit_card_number)
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

#===============================================================================
def charge(amount, credit_card_number)
  connect do |connection|
    connection.send(amount, credit_card_number)
  end
end

def connect
  begin
    connection = CreditCardServer.connect(...)
    yield connection
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

#===============================================================================
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother,
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants
    children.inject(0) do |count, child|
      count += 1 if child.alive?
      count + child.number_of_living_descendants
    end
  end

  def number_of_descendants_named(name)
    children.inject(0) do |count, child|
      count += 1 if child.name == name
      count + child.number_of_descendants_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

#===============================================================================
# Extract Surrounding Method
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother,
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants
    count_descendants_matching { |descendant| descendant.alive? }
  end

  def number_of_descendants_named(name)
    count_descendants_matching { |descendant| descendant.name == name }
  end

  def alive?
    @date_of_death.nil?
  end

  private
  def count_descendants_matching(&block)
    children.inject(0) do |count, child|
      count += 1 if yield(child)
      count + child.number_of_descendants_named(&block)
    end
  end
end

