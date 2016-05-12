require 'test_helper'
require 'mailer_helpers'

class DbMailerHelperTest < ActionMailer::TestCase
  include MailerHelpers

  setup do
    @user = {
        full_name: "Ezra Bridger",
        email: "ezra@therebellion.com"
    }

  end
  test "can send a basic template email" do
    assert true
  end

  test 'get this mailer from the db' do
    mail_template = email_me_mail_templates(:mail_template_one)
    email = GenericMailer.generic_email("mail_template_one_name", @user).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['no-reply@jedis.com'], email.from
    assert_equal mail_template.subject, email.subject
    assert_not_empty get_message_part(email, /plain/)
    assert_not_empty get_message_part(email, /html/)
  end


  test 'should correctly translate links' do
    mail_template = email_me_mail_templates(:mail_template_with_md_url)
    email = GenericMailer.generic_email("mail_template_with_md_url_name", @user).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['no-reply@jedis.com'], email.from
    assert_equal mail_template.subject, email.subject
    plain_text = get_message_part(email, /plain/)
    assert_not_empty plain_text
    assert plain_text.include? "(http://www.devis.com)"

    html_text = get_message_part(email, /html/)
    assert_not_empty html_text
    assert html_text.include? 'href="http://www.devis.com"'
  end

  test 'can replace fields with liquid' do
    mail_template = email_me_mail_templates(:mail_template_with_liquid)
    email = GenericMailer.generic_email("mail_template_with_liquid_name", @user).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['no-reply@jedis.com'], email.from
    assert_equal mail_template.subject, email.subject
    plain_text = get_message_part(email, /plain/)
    assert_not_empty plain_text
    assert plain_text.include? @user[:full_name]

    html_text = get_message_part(email, /html/)
    assert_not_empty html_text
    assert html_text.include? @user[:full_name]

  end

end


class GenericMailer < ActionMailer::Base
  include EmailMe::DbMailerHelper
  default :from => 'no-reply@jedis.com'

  def generic_email(template_name, user)
    params = {'user_full_name' => user[:full_name]}
    mail_template_email template_name, user[:email], params
  end
end