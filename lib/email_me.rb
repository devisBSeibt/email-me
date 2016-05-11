require "email_me/engine"

module EmailMe
  mattr_accessor :replacement_fields
  @@replacement_fields = {}
end
