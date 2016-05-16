module EmailMe
  class MailTemplate < ActiveRecord::Base
    default_scope { order(:id) }
  end
end
