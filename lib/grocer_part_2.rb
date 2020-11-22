require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0 
  
  while counter < coupons.length 
    item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_finder = "#{coupons[counter][:item]} W/COUPON"
    item_with_coupon = find_item_by_name_in_collection(coupon_finder, cart)
    
    if item && item[:count] >= coupons[counter][:num]
     
      if item_with_coupon
        item_with_coupon[:count] += coupons[counter][:num]
        item[:count] -= coupons[counter][:num]
      else
        item_with_coupon = {
          :item => coupon_finder,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => item[:clearance]
        }
        cart << item_with_coupon
        item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  counter = 0 
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2)).round(2)
    end
  counter += 1 
  end
cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  working_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(working_cart, coupons)
  clearance_cart = apply_clearance(couponed_cart)
  
  total_price = 0 
  counter = 0 
  while counter < clearance_cart.length
    total_price += clearance_cart[counter][:price] * clearance_cart[counter][:count]
  counter += 1
  end
  if total_price > 100
      total_price -= (total_price * 0.10)
  end
    total_price
end
