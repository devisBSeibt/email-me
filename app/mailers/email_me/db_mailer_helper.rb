require 'liquid'
require 'redcarpet'
require 'redcarpet/render_strip'

module EmailMe
  module DbMailerHelper
    def mail_template_email(template_name, to, params)

      mail_template = EmailMe::MailTemplate.find_by name: template_name
      Rails.logger.debug mail_template.content

      liquid_template = Liquid::Template.parse(mail_template.content)
      Rails.logger.debug liquid_template

      processed_template = liquid_template.render(params)

      Rails.logger.debug processed_template

      html_mail = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(processed_template)
      Rails.logger.debug html_mail

      plain_text_mail = Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(processed_template)
      Rails.logger.debug plain_text_mail

      @body_html = html_mail.html_safe
      @body_plain = plain_text_mail

      mail(to: to, subject: mail_template.subject,
           template_path: 'email_me/db_mail_template_mailer',
           template_name: :mail_template_email)

      # mail(:to => user.email, subject: mail_template.subject) do |format|
      #   format.text { render plain: plain_text_mail }
      #   format.html { render html: html_mail.html_safe }
      # end
    end
  end
end
