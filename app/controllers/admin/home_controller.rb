# frozen_string_literal: true

module Admin
  class HomeController < Admin::ApplicationController
    def top
      @orders = Order.all
      @customers = Customer.where(is_valid: true)
      @order = Order.where.not(order_status: 0).where.not(order_status: 4)
      @new_order = Order.last
    end
  end
end
