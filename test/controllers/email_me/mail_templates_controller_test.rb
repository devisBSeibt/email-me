require 'test_helper'
require 'simple_form'

module EmailMe
  class MailTemplatesControllerTest < ActionController::TestCase
    setup do
      @mail_template = email_me_mail_templates(:mail_template_one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:mail_templates)
    end

    test "should get edit" do
      get :edit, id: @mail_template
      assert_response :success
    end

    test "should update mail_template" do
      patch :update, id: @mail_template, mail_template: {
                       content: @mail_template.content,
                       description: @mail_template.description,
                       name: @mail_template.name,
                       subject: @mail_template.subject }
      assert_redirected_to mail_templates_path
    end

    test "should convert markdown to html" do
      xhr :post, :preview, id: @mail_template,
                      content: @mail_template.content
      assert_response :success
    end
  end
end
