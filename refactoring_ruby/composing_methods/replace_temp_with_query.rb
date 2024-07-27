base_price = @quantity * @item_price

if (base_price > 1000)
  base_price * 0.95
else
  base_price * 0.98
end

#===============================================================================
def base_price
  @quantity * @item_price
end

if base_price > 1000
  base_price * 0.95
else
  base_price * 0.98
end

#===============================================================================
# Original
def price
  base_price = @quantity * @item_price
  if base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  base_price * discount_factor
end

#===============================================================================

def price
  base_price * discount_factor
end

def base_price
  @base_price ||= @quantity * @item_price
end

def discount_factor
  base_price > 1000 ? 0.95 : 0.98
end
