require 'liquid'
require 'redcarpet'
require 'redcarpet/render_strip'

module EmailMe
  module DbMailerHelper
    def mail_template_email(template_name, to, params)

      mail_template = EmailMe::MailTemplate.find_by name: template_name
      liquid_template = Liquid::Template.parse(mail_template.content)
      processed_template = liquid_template.render(params)

      html_mail = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(processed_template)
      plain_text_mail = Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(processed_template)

      @body_html = html_mail.html_safe
      @body_plain = plain_text_mail

      mail(to: to, subject: mail_template.subject,
           template_path: 'email_me/db_mail_template_mailer',
           template_name: :mail_template_email)

    end
  end
end
