# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    before_action :authenticate_admin!

  end
end
