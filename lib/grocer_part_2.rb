require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |cart_item|
    coupons.each do |coupon_item|
      if cart_item[:item] == coupon_item[:item] && cart_item[:count] >= coupon_item[:num]
        cart_item[:count] -= coupon_item[:num]
        cart << {:item => "#{cart_item[:item]} W/COUPON", :price => (coupon_item[:cost]/coupon_item[:num]), :clearance => cart_item[:clearance], :count => coupon_item[:num]}
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    if cart_item[:clearance]
      cart_item[:price] -= (cart_item[:price]*0.20).round(3)
    end
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
