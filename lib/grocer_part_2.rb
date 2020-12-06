require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  new_cart = []
  cart.each do |grocery_item|
    item_count = grocery_item[:count]
    coupon_item = find_item_by_name_in_collection(grocery_item[:item], coupons)
    if coupon_item != nil
      while item_count >= coupon_item[:num]
        new_cart << {
          item: "#{coupon_item[:item]} W/COUPON",
          price: coupon_item[:cost] / coupon_item[:num],
          clearance: grocery_item[:clearance],
          count: coupon_item[:num]
        }
        item_count -= coupon_item[:num]
      end
    end
    new_cart << {
      item: grocery_item[:item],
      price: grocery_item[:price],
      clearance: grocery_item[:clearance],
      count: item_count
    }
   end 
  return new_cart
end

def apply_clearance(cart)
  cart.collect do |item|
    if item[:clearance]
      item[:price] *= 0.8
      item[:price] = item[:price].round(2)
    end
    item
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_coupons_applied = apply_coupons(consolidated_cart,coupons)
  consolidated_cart_all_discounts_applied = apply_clearance(consolidated_cart_coupons_applied)
  subtotal = consolidated_cart_all_discounts_applied.inject(0){|total,cart_item| total + (cart_item[:count]*cart_item[:price])}
  total = (subtotal > 100 ? subtotal* 0.9 : subtotal)
  return total
end
