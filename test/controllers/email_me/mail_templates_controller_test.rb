require 'test_helper'

module EmailMe
  class MailTemplatesControllerTest < ActionController::TestCase
    setup do
      @mail_template = email_me_mail_templates(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:mail_templates)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create mail_template" do
      assert_difference('MailTemplate.count') do
        post :create, mail_template: { content: @mail_template.content, description: @mail_template.description, name: @mail_template.name, subject: @mail_template.subject }
      end

      assert_redirected_to mail_template_path(assigns(:mail_template))
    end

    test "should show mail_template" do
      get :show, id: @mail_template
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @mail_template
      assert_response :success
    end

    test "should update mail_template" do
      patch :update, id: @mail_template, mail_template: { content: @mail_template.content, description: @mail_template.description, name: @mail_template.name, subject: @mail_template.subject }
      assert_redirected_to mail_template_path(assigns(:mail_template))
    end

    test "should destroy mail_template" do
      assert_difference('MailTemplate.count', -1) do
        delete :destroy, id: @mail_template
      end

      assert_redirected_to mail_templates_path
    end
  end
end
