class DisbursementsController < ApplicationController
  def index
    render json: Disbursement.for_merchant(params[:merchant]).to_json
  end
end
