require_relative './part_1_solution.rb'
require "pry"
def apply_coupons(cart, coupons)

counter = 0
while counter < coupons.length
  # return the name of the item on the coupon cart should check if item coup exist in cart
  cart_item = find_item_by_name_in_collection(coupons[counter][:item],cart)
  # check if item/w/coupon exist in the cart
  item_w_coupon = "#{coupons[counter][:item]} W/COUPON"
  # finds item similar with the coupon tag in the cart
  cart_item_w_coupon = find_item_by_name_in_collection(item_w_coupon,cart)
  #create a conditonal to check if not only cart in item && if there is enough item for the coupon to apply
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      # if cart_item_w_coupon exist apply the coupon
        if cart_item_w_coupon
          # take the number of coupon count and add it to the number of items
            cart_item_w_coupon[:count] += coupons[counter][:num]
            # subtract the number of coupon applied to the number of the count
            cart_item[:count] -= coupons[counter][:num]
          else
            # if that cart item with coupon does not exist build it again
            cart_item_w_coupon = {
              :item => item_w_coupon,
              # take the price of the item divided by the number of coupon applied
              :price => coupons[counter][:cost] / coupons[counter][:num],
              # number of items the coupon applies to
              :count => coupons[counter][:num],
              # take orginal cart item and grab key value pair
              :clearance => cart_item[:clearance],
            }
            # add the cart_item_w_coupon to the cart
            cart << cart_item_w_coupon
            # subtract number from the cart item count
            cart_item[:count] -= coupons[counter][:num]
        end
    end
    counter += 1
end
cart
end

def apply_clearance(cart)
  counter = 0
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end
    counter += 1
  end
  cart
end

def checkout(cart, coupons)
  # * consolidate_cart
  consolidated_cart = consolidate_cart(cart)
  # * apply_coupons
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  # * apply_clearance
  final_cart = apply_clearance(coupon_cart)

  total = 0
  counter = 0

  while counter < final_cart.length
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end

  if total > 100
    total -= (total * 0.10)
  end
  total
end
