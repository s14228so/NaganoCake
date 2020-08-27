class Customer::HomeController < ApplicationController

  def top
    @recomend_items = Item.selling.limit(9).order(updated_at: :DESC)
    @cart_items = current_customer&.cart_items
  end

  def about; end
end
