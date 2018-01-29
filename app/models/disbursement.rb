class Disbursement < ApplicationRecord
  belongs_to :order

  scope :for_merchant, ->(merchant_id = nil) do
    merchant_condition = merchant_id ? 'orders.merchant_id = :merchant_id AND ' : ''
    joins(:order).where(
      merchant_condition + 'disbursements.created_at BETWEEN :start_date AND :end_date',
      {merchant_id: merchant_id,
      start_date: Time.zone.now.beginning_of_week,
      end_date: Time.zone.now.end_of_week}
    )
  end

  def self.disburse_on_background
    DisburseMerchantsJob.set(queue: 'urgent').perform_later
  end

  def self.disburse!
    scope = Order.completed
    scope.each do |order|
      create!(
        order_id: order.id,
        amount: disburse_amount(order)
      )
    end
  end

  def self.disburse_amount(order)
    order.amount - (order.amount * percentage(order.amount))
  end

  def self.percentage(amount)
    if amount.between?(50, 300)
      0.0095
    elsif amount > 300
      0.0085
    else
      0.01
    end
  end
end
