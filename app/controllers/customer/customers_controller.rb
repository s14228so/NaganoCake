# frozen_string_literal: true

module Customer
  class CustomersController < ApplicationController

    before_action :authenticate_customer!

    def show
      @customer = Customer.find(params[:id])
    end

    def create
      @customer = Customer.new(customer_params)
      @customer.save
      redirect_to root_path
    end

    def edit
      @customer = Customer.find(params[:id])
    end

    def update
      @customer = Customer.find(params[:id])

      if @customer.update(customer_params)
        if customer_signed_in?
          flash[:notice] = "登録情報が更新されました。"
          redirect_to customer_path(current_customer)
        else
          redirect_to request.referrer
        end
      else
        flash[:notice] = "項目を正しく記入してください"
        redirect_to request.referrer
      end
    end

    def quit
      @customer = Customer.find(params[:id])
    end

    def invalid
      @customer.update(customer_params)
      reset_session
      flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to root_path
    end

    private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :postcode, :address, :phone_number, :is_valid)
    end

    def set_customer
      if @customer != current_customer
        redirect_to root_path
      end
    end
  end
end

