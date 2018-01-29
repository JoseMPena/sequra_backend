require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  before :all do
    parsed_orders = JSON.parse(file_fixture('orders.json').read)
    @orders = parsed_orders.first.last
  end

  it 'should disburse completed orders' do
    Order.create(@orders.find { |order| !order['completed_at'].blank? })
    expect { Disbursement.disburse! }.to change(Disbursement, :count).by 1
  end

  it 'should not disburse incomplete orders' do
    Order.create(@orders.find { |order| order['completed_at'].blank? })
    expect { Disbursement.disburse! }.to_not change(Disbursement, :count)
  end

  it 'should charge 1% to orders lower than 50€' do
    Order.create(@orders.find do |order|
      order['amount'].to_f < 50.0 && !order['completed_at'].blank?
    end)
    Disbursement.disburse!
    disburse = Disbursement.first
    amount = disburse.order.amount
    expect(disburse.amount).to eq amount - (amount * 0.01)
  end

  it 'should charge 0.95% to orders between 50€ and 300€' do
    Order.create(@orders.find do |order|
      order['amount'].to_f.between?(50.0, 300.0) && !order['completed_at'].blank?
    end)
    Disbursement.disburse!
    disburse = Disbursement.first
    amount = disburse.order.amount
    expect(disburse.amount).to eq amount - (amount * 0.0095)
  end

  it 'should charge 0.85% to orders higher than 300€' do
    Order.create(@orders.find do |order|
      order['amount'].to_f > 300.0 && !order['completed_at'].blank?
    end)
    Disbursement.disburse!
    disburse = Disbursement.first
    amount = disburse.order.amount
    expect(disburse.amount).to eq amount - (amount * 0.0085)
  end
end
