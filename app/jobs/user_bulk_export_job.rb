# frozen_string_literal: true

class UserBulkExportJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    zipped_blob = UserBulkExportService.call
  rescue StandardError => e
    Admin::UserMailer.with(user: initiator, error: e).bulk_export_fail.deliver_now
  else
    Admin::UserMailer.with(user: initiator, zipped_blob:).bulk_export_done.deliver_now
  ensure
    zipped_blob.purge
  end
end
