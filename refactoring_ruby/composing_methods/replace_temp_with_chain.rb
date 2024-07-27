class Select
  def options
    @options ||= []
  end

  def add_option(arg)
    options << arg
  end
end

select = Select.new
select.add_option(1999)
select.add_option(2000)
select.add_option(2001)
select.add_option(2002)
select

#===============================================================================
class Select
  def self.with_options(option)
    select = self.new
    select.options << option
    select
  end

  def options
    @options ||= []
  end

  def and(option)
    options << option
    self
  end
end

select = Select.with_option(1999).and(2000).and(2001).and(2002)
