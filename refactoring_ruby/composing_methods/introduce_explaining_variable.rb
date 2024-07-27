def price
  # price is base price - quantity discount + shipping
  return @quantity * @item_price -
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@quantity * @item_price * 0.1, 100.0].min
end

#===============================================================================
def price
  base_price = @quantity * @item_price
  quantity_discount = [0, @quantity - 500].max * @item_price * 0.05
  shipping_fee = [base_price * 0.1, 100.0].min

  return base_price - quantity_discount + shipping
end

#===============================================================================
def price
  return base_price - quantity_discount + shipping
end

def base_price
  @quantity * @item_price
end

def quantity_discount
  [0, @quantity - 500].max * @item_price * 0.05
end

def shipping_fee
  [base_price * 0.1, 100.0].min
end
