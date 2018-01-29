class DisburseMerchantsJob < ApplicationJob
  queue_as :urgent

  def perform(*args)
    Disbursement.delay(run_at: Date.today.next_week).disburse!
  end
end
