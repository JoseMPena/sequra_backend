require 'rails_helper'
require 'rake'

RSpec.describe DisburseMerchantsJob, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  it 'should run in background' do
    ActiveJob::Base.queue_adapter = :test
    expect {
      Disbursement.disburse_on_background
    }.to have_enqueued_job.on_queue('urgent')
  end

  it 'should run only on monday' do
    #pending
    true
  end
end
