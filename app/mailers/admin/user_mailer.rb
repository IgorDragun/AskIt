# frozen_string_literal: true

module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail to: @user.email, subject: I18n.t('admin.users.user_mailer.bulk_import_done.subject')
    end

    def bulk_import_fail
      @user = params[:user]
      @error = params[:error]

      mail to: @user.email, subject: I18n.t('admin.users.user_mailer.bulk_import_fail.subject')
    end

    def bulk_export_done
      @user = params[:user]
      zipped_blob = params[:zipped_blob]

      attachments[zipped_blob.attachable_filename] = zipped_blob.download
      mail to: @user.email, subject: I18n.t('admin.users.user_mailer.bulk_export_done.subject')
    end

    def bulk_export_fail
      @user = params[:user]
      @error = params[:error]

      mail to: @user.email, subject: I18n.t('admin.users.user_mailer.bulk_export_fail.subject')
    end
  end
end
