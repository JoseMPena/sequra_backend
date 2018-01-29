
  module SpecSupport
    require 'rails_helper'

    def self.load_orders
      parsed_orders = JSON.parse(file_fixture('orders.json').read)
      @orders = parsed_orders.first.last
    end
  end