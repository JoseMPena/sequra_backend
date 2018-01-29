require 'rails_helper'

RSpec.describe DisbursementsController, type: :controller do
#pending test data
  describe 'GET disbursements' do
    it 'returns disbursements for all merchants' do
      get :index
      expect(response).to have_http_status(:success) #pending
    end

    it 'returns disbursements for a given merchant' do
      get :index, params: {merchant: 1}
      # get 'disbursements/?merchant_id=1'
      expect(response).to have_http_status(:success) #pending
    end
  end
end
