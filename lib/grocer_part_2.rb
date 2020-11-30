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
  total = 0.00
  consolidated_cart = consolidate_cart(cart)
  coupons_applied_cart = apply_coupons(consolidated_cart, coupons)
  all_discounts_applied_cart = apply_clearance(coupons_applied_cart)

  all_discounts_applied_cart.each do |item_entry|
    total += (item_entry[:price]*item_entry[:count]).round(3)
  end

    if total >= 100
      total -= (total*0.10).round(3)
    end
    total
end
